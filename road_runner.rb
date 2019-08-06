require 'json'
require 'test/unit'

json_data = File.read("executor.json")
execution_order_data = JSON.parse(json_data)

def find(hash_response,key)
	key_split = key.split(".")
	for split in key_split
		hash_response = hash_response[split]
	end
	return hash_response
end

TestData = Struct.new :name , :data
AssertionData = Struct.new :fieldname, :expected, :actual

TEST_DATA = []
global_map = {}

# Execute the roads and build the test data
for road in execution_order_data["Execution Order"]

	# get the unique name, used to store the fields in the global map
	unique_name = road["uniqueName"]

	# get the stored response fields
	stored_fields = road["storedResponseFields"]

	# get the fully qualified file name
	class_qualified_name = road["sampleClassNames"]["node"].gsub('.','/')

	# Get the class name
	class_name = class_qualified_name.split("/").last

	# Clear all the stored response fields in the global map
	for field in stored_fields
		global_map.delete(unique_name + field)
	end

	# get the pre-requisite sample code
	dependent_sample_code = road["prerequisiteRoad"]

	# get the fields required to be passed to this sample code from the pre-requisite sample code.
	dependent_fields = road["dependentFieldMapping"]

	# to store the fields to be sent to the sample code
	input_fields = []

	# populate test data / data regarding the fields missing to be passed as input
	data = []

	# define a variable to determine if sample code can be called.
	call_sample_code = true

	# Check if the required fields are in the global map
	for field in dependent_fields
		if global_map.has_key?(dependent_sample_code + field)
			input_fields.push(global_map[dependent_sample_code + field])
		else
			data.push(AssertionData.new("dependentfield-" + field,true,false))
			# as input fields are missing, sample code cannot be called
			call_sample_code = false
		end
	end

	if call_sample_code
		# generate the file name
		file_name = class_qualified_name + ".rb"

		# load the file
		require_relative file_name

		# Create an object instance of the class
		instance = Object.const_get(class_name).new

		# Call the function with the argument list
		response, http_status = instance.main(input_fields)

		# Convert the Json response to hash
		hash_response = JSON.parse(response)

		data.push(AssertionData.new("httpStatus",road["Assertions"]["httpStatus"], http_status.to_s))
		for required_field in road["Assertions"]["requiredFields"]
			data.push(AssertionData.new(required_field,hash_response.has_key?(required_field),true))
		end
		for expected_value in road["Assertions"]["expectedValues"]
			actual_value = find(hash_response,expected_value["field"])
			data.push(AssertionData.new(expected_value["field"],expected_value["value"], actual_value))
		end
	end
		# Ruby test cases work only if the dynamic test case name starts with 'test'
		# Populate the test data
		TEST_DATA.push(TestData.new("test_" + class_name.downcase, data))
end

# Start Validations after building the test data, all validations are done together
Class.new Test::Unit::TestCase do
	TEST_DATA.each do |test|
		define_method(test.name) do
			test.data.each do |i|
				# check if value is boolean, done to give different assertion messages
				if !!i.actual == i.actual
					if i.fieldname.include? "dependentfield-"
						assert_equal(i.expected,i.actual,"Sample code wasn't executed as this field - " + i.fieldname.gsub("dependentfield-","") + " wasn't passed.")
					else
						assert_equal(i.expected,i.actual,i.fieldname + " is a required field, but not present in the response.")
					end
				else
					assert_equal(i.expected,i.actual,i.fieldname + " doesn't match expected value in the response.")
				end
			end
		end
	end
end



