require 'json'
require 'test/unit'

json_data = File.read("roads.json")
hash_roads = JSON.parse(json_data)

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

# Build the test data
for road in hash_roads["roads"]
	# get the fully qualified file name
	class_qualified_name = road["sampleClassName"]["node"].gsub('.','/')
	file_name = "Samples/" + class_qualified_name + ".rb"

	# load the file
	require_relative file_name

	# Get the class name from file
	class_name = class_qualified_name.split("/").last				

	# Create an object instance of the class
	instance = Object.const_get(class_name).new

	# Call the function
	response, http_status = instance.main(false)

	# Convert the Json response to hash
	hash_response = JSON.parse(response)
	
	#populate test data
	data = []		
	data.push(AssertionData.new("httpStatus",road["assertions"]["httpStatus"], http_status.to_s))
	for required_field in road["assertions"]["requiredFields"]
		data.push(AssertionData.new(required_field,hash_response.has_key?(required_field),true))
	end
	for expected_value in road["assertions"]["expectedValues"]
		actual_value = find(hash_response,expected_value["field"])
		data.push(AssertionData.new(expected_value["field"],expected_value["value"], actual_value))
	end
	# Ruby test cases work only if the dynamic test case name starts with 'test'
	TEST_DATA.push(TestData.new("test_" + class_name.downcase, data))
	print("\n")	
end

# Start Validations after building the test data		
Class.new Test::Unit::TestCase do
	TEST_DATA.each do |test|
		define_method(test.name) do
			test.data.each do |i|
				# check if value is boolean, done to give different assertion messages
				if !!i.actual == i.actual
					assert_equal(i.expected,i.actual,i.fieldname + " is a required field, but not present in the response.")
				else
					assert_equal(i.expected,i.actual,i.fieldname + " doesn't match expected value in the response.")
				end
			end
		end
	end
end



