require 'rails_helper'

RSpec.describe Ip2LocationService, type: :service do

  context "when IPV4 is successfully process" do

    before do
     @ip2_location_v4 = Ip2LocationService.new({
          :url =>"http://download.ip2location.com/lite/IP2LOCATION-LITE-DB1.CSV.ZIP",
          :version => "v4"
     })
    end

    it "should be downloaded ipv4 zip file" do
      zip_ipv4 = @ip2_location_v4.download_zip
      expect(zip_ipv4).to be_a Tempfile
     end

    it "should be extracted CSV file" do
      zip_ipv4 = @ip2_location_v4.download_zip
      csv_ipv4 = @ip2_location_v4.extract_csv zip_ipv4.path
      expect(csv_ipv4).to be_a Object
    end

    it "should be persist to table" do
      zip_ipv4 = @ip2_location_v4.download_zip
      csv_ipv4 = @ip2_location_v4.extract_csv zip_ipv4.path
      count = @ip2_location_v4.persist_data csv_ipv4.read
      puts count
    end

  end




end
