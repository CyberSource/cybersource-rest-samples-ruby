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
AssertionData = Struct.new :expected, :actual, :message

TEST_DATA = []
global_map = {}
i = 0

# Execute the roads and build the test data
for road in execution_order_data["Execution Order"]

	# to give unique test name for roads with same unique name
	i = i + 1;

	# populate test data / data regarding the fields missing to be passed as input / exceptions
	data = []

	# get the fully qualified file name
	class_qualified_name = road["sampleClassNames"]["ruby"].gsub('.','/')

	# Get the class name
	class_name = class_qualified_name.split("/").last

	begin
		# get the unique name, used to store the fields in the global map
		unique_name = road["uniqueName"]

		# get the stored response fields
		stored_fields = road["storedResponseFields"]

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

		# define a variable to determine if sample code can be called.
		call_sample_code = true

		# Check if the required fields are in the global map
		for field in dependent_fields
			if global_map.has_key?(dependent_sample_code + field)
				input_fields.push(global_map[dependent_sample_code + field])
			else
				data.push(AssertionData.new(true, false, "Sample code wasn't executed as the dependent field \"" + field + "\" wasn't passed."))
				# as dependent input fields are missing, sample code cannot be called
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

			if input_fields.length > 0
				response, http_status = instance.run(*input_fields)
			else
				response, http_status = instance.run()
			end

			# Convert the Json response to hash
			hash_response = JSON.parse(response)

			# Store the response values into global map which will be used for subsequent requests
			for field in stored_fields
				value = find(hash_response,field)
				unless value.nil?
					global_map.store(unique_name + field, value)
				end
			end

			unless road["Assertions"]["httpStatus"].empty?
				data.push(AssertionData.new(road["Assertions"]["httpStatus"], (http_status.nil?) ? http_status : http_status.to_s, "Actual value of \"httpStatus\" field doesn't match Expected value in the response."))
			end

			for required_field in road["Assertions"]["requiredFields"]
				actual_value = find(hash_response,required_field)
				data.push(AssertionData.new(!actual_value.nil?, true, required_field + " - is a required field, but not present in the response."))
			end

			for expected_value in road["Assertions"]["expectedValues"]
				actual_value = find(hash_response,expected_value["field"])
				data.push(AssertionData.new(expected_value["value"], actual_value, "Actual value of \"" + expected_value["field"] + "\" field doesn't match Expected value in the response."))
			end
		end
	rescue StandardError => err
		# in case of a standard exception
		data.push(AssertionData.new(true, false, "Sample code execution/comparison failed due to an exception - " + err.message))
	rescue LoadError => err
		# in case of a load error exception, where the sample code is not found.
		data.push(AssertionData.new(true, false, class_name + " sample code wasn't found. " + err.message))
	ensure
		# Ruby test cases work only if the dynamic test case name starts with 'test'
		# Populate the test data, only if validations are mentioned or exceptions occur or dependent fields are missing
		if(data.length > 0)
			TEST_DATA.push(TestData.new("test_" + i.to_s + "_" + class_name.downcase, data))
		end
	end
end

# Start Validations after building the test data, all validations are done together
Class.new Test::Unit::TestCase do
	TEST_DATA.each do |test|
		define_method(test.name) do
			test.data.each do |i|
				assert_equal(i.expected,i.actual,i.message)
			end
		end
	end
end



