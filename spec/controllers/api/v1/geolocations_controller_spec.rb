require 'rails_helper'

describe API::V1::GeolocationsController do

  describe "GET #show/:id" do

    context "when is successfully find" do

      it "should be valid status code" do
        get :show, id: "175.157.254.70", format: :json
        location_response = JSON.parse(response.body, symbolize_names: true)
        expect(location_response[:status]).to eq(200)
      end

      it "should be valid status code" do
        get :show, id: "175.157.254.70", format: :json
        should respond_with 200
      end

      it "should not be valid status code" do
        get :show, id: "0", format: :json
        should_not respond_with 200
      end


    end


  end
end