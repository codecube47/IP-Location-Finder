namespace :ip2location do
  desc 'Ip2location'
  task :start => :environment do
    result = []
    result << "\n"
    result << "Ip2Location service start at #{Time.now.utc}"
    result << "============================================"
    result << "\n"

    result << "Start to process ipv4"
    result << "\n"

    ip2location =  Ip2LocationService.new({
         :url =>"http://download.ip2location.com/lite/IP2LOCATION-LITE-DB1.CSV.ZIP",
         :version => "v4"
    })

    result << "downloading ipv4 zip file"
    zip = ip2location.download_zip
    result << "done"
    result << "\n"
    puts result

    result << "extracting ipv4 zip file"
    csv = ip2location.extract_csv zip
    result << "done"
    result << "\n"
    puts result

    result << "persisting CSV data to table"
    count = ip2location.persist_data csv.read
    result << "done"
    result << "\n"
    puts result

    result << "Cleaning template files"
    ip2location.remove_temp
    result << "done"
    result << "\n"
    puts result

    result << "Ip2Location service end at :#{Time.now.utc}"
    result << "============================================"
    puts result
  end

end

