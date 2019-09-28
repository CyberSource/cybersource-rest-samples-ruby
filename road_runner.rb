require 'json'
require 'test/unit'

json_data = File.read("executor.json")
ROADS = JSON.parse(json_data)

def find(hash_response,key)
	key_split = key.split(".")
	for s in key_split
		if s.include? "["
			hash_response = hash_response[s.split("[").first][0]
		else
			hash_response = hash_response[s]
		end
	end
	return hash_response
end

global_map = {}
i = 0

Class.new Test::Unit::TestCase do
	ROADS["Execution Order"].each do |road|

		# to give unique test name for roads with same unique name
		i = i + 1;

		# get the fully qualified file name
		class_qualified_name = road["sampleClassNames"]["ruby"].gsub('.','/')

		# Get the class name
		class_name = class_qualified_name.split("/").last

		# dynamic tests in ruby start with "test"
		define_method("test_" + i.to_s + "_" + class_name.downcase) do
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
				
				if class_qualified_name.include? "Token_Management"
			    		input_fields.push("93B32398-AD51-4CC2-A682-EA3E93614EB1")
				elsif class_qualified_name.include? "GetReportDefinition"
			    		input_fields.push("TransactionRequestClass")
				end

				# Check if the required fields are in the global map
				for field in dependent_fields
					if global_map.has_key?(dependent_sample_code + field)
						input_fields.push(global_map[dependent_sample_code + field])
					else
						assert_equal(true, false, "Sample code wasn't executed as the dependent field \"" + field + "\" wasn't passed.")
						# as dependent input fields are missing, sample code cannot be called
						call_sample_code = false
					end
				end
				
				if !dependent_sample_code.empty?
					if class_qualified_name.include? "Retrieve" or class_qualified_name.include? "Delete"
		    				sleep 20
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

					if !response.nil? and !response.empty?
						# Convert the Json response to hash
						hash_response = JSON.parse(response)

						# Store the response values into global map which will be used for subsequent requests
						for field in stored_fields
							value = find(hash_response,field)
							unless value.nil?
								global_map.store(unique_name + field, value)
							end
						end

						# Start assertions

						unless road["Assertions"]["httpStatus"].nil? or road["Assertions"]["httpStatus"].empty?
							assert_equal(road["Assertions"]["httpStatus"], (http_status.nil?) ? http_status : http_status.to_s, "Actual value of \"httpStatus\" field doesn't match Expected value in the response.")
						end
					
						unless road["Assertions"]["requiredFields"].nil?
							for required_field in road["Assertions"]["requiredFields"]
								actual_value = find(hash_response,required_field)
								assert_equal(true, !actual_value.nil?, required_field + " - is a required field, but not present in the response.")
							end
						end

						unless road["Assertions"]["expectedValues"].nil?
							for expected_value in road["Assertions"]["expectedValues"]
								actual_value = find(hash_response,expected_value["field"])
								assert_equal(expected_value["value"], actual_value, "Actual value of \"" + expected_value["field"] + "\" field doesn't match Expected value in the response.")
							end
						end
					else
						assert_equal(true, false, "Sample code execution failed as response returned is null/empty")
					end
				end

			rescue StandardError => err
				# in case of a standard exception
				assert_equal(true, false, "Sample code wasn't executed as an exception occured in road runner - " + err.message)

			rescue LoadError => err
				# in case of a load error exception, where the sample code is not found/cannot be loaded
				assert_equal(true, false, class_name + " sample code wasn't found. " + err.message)
			end
		end
	end
end

