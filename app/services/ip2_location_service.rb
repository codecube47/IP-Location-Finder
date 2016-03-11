require 'zip'
require 'open-uri'

class Ip2LocationService

  def initialize(params)
    @url = params[:url]
    @version = params[:version]
  end

  def process
    download_zip
  end

  # download zip file
  def download_zip
    url = URI.parse(@url)
    @zipfile = Tempfile.new("downloaded")

    begin
      open(url) do |http|
        response = http.read
        @zipfile.binmode
        @zipfile.write(response)
      end
    rescue
      @zipfile.close
      @zipfile.unlink
    end
    return @zipfile
  end

  # extract file CSV file from ZIP file
  def extract_csv zip_path

    Zip::File.open(zip_path) do |file|

      # get CSV file
      entry = file.glob('*.CSV').first

      # read CSV file
      @content = entry.get_input_stream
    end
   return @content
  end

  #save CSV file to table
  def persist_data data
    data_table =""

    # check_vesion
    if @version.present?

      # check ip version
       if @version == "v4"
         data_table = "ip2_location_v4s"
       elsif @version == "v6"
         data_table = "ip2_location_v6s"
       end

       # Truncate all old data
       ActiveRecord::Base.connection.execute("truncate #{data_table}")
       dbconn = ActiveRecord::Base.connection_pool.checkout
       raw  = dbconn.raw_connection
       count = nil

       # add data to table one by one
       result = raw.copy_data "COPY #{data_table} FROM STDIN WITH (FORMAT CSV, DELIMITER ',',  NULL '')" do
         data.lines.map.each do |line|
           raw.put_copy_data line
         end
       end

       # check row count
       count = dbconn.select_value("select count(*) from #{data_table}").to_i
       ActiveRecord::Base.connection_pool.checkin(dbconn)
       count
  else
      puts "please provide version"
  end
  end

  def remove_temp
    @zipfile.close
    @zipfile.unlink
  end
end