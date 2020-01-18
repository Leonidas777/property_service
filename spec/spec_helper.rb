require 'rack/test'
require 'rspec'
require 'factory_bot'
require 'db_cleaner'

ENV['RACK_ENV'] = 'test'

require File.expand_path '../../app.rb', __FILE__

module RSpecMixin
  include Rack::Test::Methods
  def app() Sinatra::Application end
end

RSpec.configure do |c|
  c.include RSpecMixin
  c.include FactoryBot::Syntax::Methods
end

FactoryBot.definition_file_paths = %w{./spec/factories}
FactoryBot.find_definitions
