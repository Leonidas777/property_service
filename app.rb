require 'sinatra'
require 'sinatra/activerecord'
require 'pry'

current_dir = Dir.pwd
Dir["#{current_dir}/models/*.rb"].each { |file| require file }

before do
  content_type 'application/json'
end

get '/stats' do
  @properties = Property.where(
    property_type: params[:property_type],
    offer_type: params[:marketing_type]
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
