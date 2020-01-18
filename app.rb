require 'sinatra'
require 'sinatra/activerecord'
require 'pry'

current_dir = Dir.pwd
Dir["#{current_dir}/models/*.rb"].each { |file| require file }

RADIUS = 5000.0.freeze

before do
  content_type 'application/json'
end

get '/stats' do
  @properties =
    Property
      .where(
        property_type: params[:property_type],
        offer_type: params[:marketing_type]
      )
      .where('earth_distance(ll_to_earth(lat, lng), ll_to_earth(:current_lat, :current_lng)) < :radius',
        current_lat: current_lat,
        current_lng: current_lng,
        radius: RADIUS
      )

  @properties.map do |property|
    property.slice(
      :house_number,
      :street,
      :city,
      :zip_code,
      :lat, :lng,
      :price
    )
  end.to_json
end

def current_lat
  params[:lat].to_f
end

def current_lng
  params[:lng].to_f
end
