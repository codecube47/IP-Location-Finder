Rails.application.routes.draw do
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :geolocations, :only => [:show] ,:constraints => { :id => /[0-9.: a-z A-Z]+/ }
    end
  end
end
