require 'sinatra'
require 'sinatra/activerecord'
require 'pry'

current_dir = Dir.pwd
Dir["#{current_dir}/models/*.rb",
    "#{current_dir}/helpers/*.rb"].each { |file| require file }

before do
  content_type 'application/json'
end

before { check_params }

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
        radius: Property.RADIUS_FOR_SEARCH
      )

  if @properties.count == 0
    status 404
    return { message: 'No data for given location' }.to_json
  end

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
