require 'cybersource_rest_client'
require 'csv'
require 'thread'
require_relative '../../../data/Configuration.rb'

class SimpleAuthorizationInternetParallel
  CSV_FILENAME = "PerformanceMetrics_Parallel_Calls_CP_parallel_10_connections.csv"

  # Array of number of calls you want to test with
  NUMBER_OF_CALLS_ARRAY = [5, 10, 20, 50, 100, 200, 300, 500]

  def run_parallel_tests
    puts "=== STARTING PARALLEL CALLS ANALYSIS ==="
    puts "Number of Calls: #{NUMBER_OF_CALLS_ARRAY.inspect}"
    puts "Results will be exported to CSV file: #{CSV_FILENAME}"
    puts "========================================"

    CSV.open(CSV_FILENAME, "w") do |csv|
      csv << ["Number of Calls", "Best Time (ms)", "Worst Time (ms)", "Total Time (ms)", "Successful Calls", "Average Time (ms)", "Worst Call Number" , "Total Time to create Threads (ms)"]

      NUMBER_OF_CALLS_ARRAY.each do |num_calls|
        puts "\n--- Running #{num_calls} parallel calls ---"
        results = run_concurrent_payments(num_calls)
        log_to_csv(csv, num_calls, results)
        sleep 2 # Let things settle between test runs
      end
    end

    puts "\n=== ANALYSIS COMPLETE ==="
    puts "Results exported to: #{CSV_FILENAME}"
  end

  def run_concurrent_payments(number_of_calls)
    threads = []
    results = []
    mutex = Mutex.new

    start_time = Process.clock_gettime(Process::CLOCK_MONOTONIC, :nanosecond)

    number_of_calls.times do |i|
      threads << Thread.new(i+1) do |call_id|
        result = execute_single_payment(call_id)
        mutex.synchronize { results << result }
      end
    end
    thread_send_end_time = Process.clock_gettime(Process::CLOCK_MONOTONIC, :nanosecond)
    total_time_to_create_threads = (thread_send_end_time - start_time) / 1_000_000 # ms
    # Ensure all threads complete before proceeding
    threads.each(&:join)

    end_time = Process.clock_gettime(Process::CLOCK_MONOTONIC, :nanosecond)
    total_time = (end_time - start_time) / 1_000_000 # ms
    { results: results, total_time: total_time , total_time_to_create_threads: total_time_to_create_threads}
  end

  def execute_single_payment(call_id)
    begin
      request_obj = CyberSource::CreatePaymentRequest.new

      client_reference_information = CyberSource::Ptsv2paymentsClientReferenceInformation.new
      client_reference_information.code = "TC50171_#{call_id}_#{Time.now.to_i}_#{rand(10000)}"
      request_obj.client_reference_information = client_reference_information

      processing_information = CyberSource::Ptsv2paymentsProcessingInformation.new
      processing_information.capture = false
      request_obj.processing_information = processing_information

      payment_information = CyberSource::Ptsv2paymentsPaymentInformation.new
      card = CyberSource::Ptsv2paymentsPaymentInformationCard.new
      card.number = "4111111111111111"
      card.expiration_month = "12"
      card.expiration_year = "2031"
      payment_information.card = card
      request_obj.payment_information = payment_information

      order_information = CyberSource::Ptsv2paymentsOrderInformation.new
      amount_details = CyberSource::Ptsv2paymentsOrderInformationAmountDetails.new
      amount_details.total_amount = "102.21"
      amount_details.currency = "USD"
      order_information.amount_details = amount_details
      bill_to = CyberSource::Ptsv2paymentsOrderInformationBillTo.new
      bill_to.first_name = "John"
      bill_to.last_name = "Doe"
      bill_to.address1 = "1 Market St"
      bill_to.locality = "san francisco"
      bill_to.administrative_area = "CA"
      bill_to.postal_code = "94105"
      bill_to.country = "US"
      bill_to.email = "test@cybs.com"
      bill_to.phone_number = "4158880000"
      order_information.bill_to = bill_to
      request_obj.order_information = order_information

      config = MerchantConfiguration.new.merchantConfigProp()
      api_client = CyberSource::ApiClient.new
      api_instance = CyberSource::PaymentsApi.new(api_client, config)
      start_time = Process.clock_gettime(Process::CLOCK_MONOTONIC, :nanosecond)
      data, status_code, _headers = api_instance.create_payment(request_obj)
      end_time = Process.clock_gettime(Process::CLOCK_MONOTONIC, :nanosecond)
      execution_time = (end_time - start_time) / 1_000_000 # ms
      puts "Call ##{call_id} completed - ResponseCode: #{status_code} - Time: #{execution_time}ms"
      { call_id: call_id, success: status_code.to_i.between?(200,299), status_code: status_code, execution_time: execution_time }
    rescue => e
      execution_time = ((Time.now - start_time) * 1000).to_i
      puts "Call ##{call_id} failed: #{e.message}"
      { call_id: call_id, success: false, status_code: e.respond_to?(:code) ? e.code : nil, execution_time: execution_time }
    end
  end

  def log_to_csv(csv, number_of_calls, result_obj)
    results = result_obj[:results]
    total_time = result_obj[:total_time]
    total_time_to_create_threads = result_obj[:total_time_to_create_threads]

    successful = results.count { |res| res[:success] }
    times = results.select { |res| res[:success] }.map { |res| res[:execution_time] }
    min_time = times.min || 0
    max_time = times.max || 0
    avg_time = successful > 0 ? (times.sum / successful.to_f).round(2) : 0
    worst_call = results.find { |res| res[:execution_time] == max_time }
    worst_call_number = worst_call ? worst_call[:call_id] : nil

    csv << [number_of_calls, min_time, max_time, total_time, successful, avg_time, worst_call_number , total_time_to_create_threads]

    puts "  Calls: #{number_of_calls}, Success: #{successful}/#{number_of_calls}, Avg: #{avg_time}ms, Total: #{total_time}ms , Total Time for thread creation: #{total_time_to_create_threads}ms"
  end
end

if __FILE__ == $0
  SimpleAuthorizationInternetParallel.new.run_parallel_tests
end
