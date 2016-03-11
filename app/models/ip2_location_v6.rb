class Ip2LocationV6 < ActiveRecord::Base
  def self.gel_location ip_int
    where("#{ip_int} <= ip_to").select(:country_code,:country_name).limit(1)
  end
end
