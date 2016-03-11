class API::V1::GeolocationsController < ApplicationController

  def show
   begin
    # convert params to ip object
    ip_addr = IPAddr.new "#{params[:id]}"

    # search location by ip version
    render json: get_location("v4",ip_addr.to_i), status: 200 if ip_addr.ipv4?
    render json: get_location("v6",ip_addr.to_i), status: 200 if ip_addr.ipv6?

   rescue Exception =>e
     # hanggle exeption
     render json: { errors: e.message }, status: 422
   end
  end

  private
  # find location and format json
  def get_location version, int_ip
       case version
           when "v4"
             {:location =>Ip2LocationV4.gel_location(int_ip), :status=>200}
           when "v6"
             {:location =>Ip2LocationV6.gel_location(int_ip), :status=>200}
        end
  end
end
