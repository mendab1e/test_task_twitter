require 'dotenv/load'
require 'sinatra'
require 'sinatra/reloader'
require_relative 'app/services/twitter_fetcher.rb'

get '/' do
  @query = params[:query]
  @max_id = params[:max_id]

  unless @query.to_s.empty?
    @result = TwitterFetcher.new(@query, max_id: @max_id).fetch
  end

  slim :index
end
