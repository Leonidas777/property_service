require 'sinatra'
require 'sinatra/activerecord'

current_dir = Dir.pwd
Dir["#{current_dir}/models/*.rb"].each { |file| require file }

before do
  content_type 'application/json'
end

get '/stats' do
  @properties = Property.first(100)

  @properties.map do |property|
    property.offer_type
  end.to_json
end
