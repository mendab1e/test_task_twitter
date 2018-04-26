# spec/spec_helper.rb
require 'rspec'
require 'webmock/rspec'
require 'rack/test'
require 'vcr'

ENV['RACK_ENV'] = 'test'

require File.expand_path '../../application.rb', __FILE__

module RSpecMixin
  include Rack::Test::Methods
  def app() Sinatra::Application end
end

VCR.configure do |config|
  config.cassette_library_dir = 'spec/cassettes'
  config.hook_into :webmock
  config.filter_sensitive_data('<TOKEN>') do |interaction|
    interaction.request.headers['Authorization'].first
  end
end

RSpec.configure do |config|
  config.include RSpecMixin
end
