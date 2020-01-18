require 'sinatra'
require 'sinatra/activerecord'
require 'pry'

current_dir = Dir.pwd
Dir["#{current_dir}/models/*.rb"].each { |file| require file }

before do
  content_type 'application/json'
end

get '/stats' do
  @properties = Property.first(100)

  # binding.pry

  @properties.map do |property|
    property.slice(:offer_type, :property_type, :street, :lng, :lat, :construction_year, :price)
  end.to_json
end
