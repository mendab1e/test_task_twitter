require 'dotenv/load'
require 'sinatra'
require 'sinatra/reloader'
require_relative 'app/services/twitter_fetcher.rb'

get '/' do
  @query = params[:query]
  @from_id = params[:from_id]
  @tweets = TwitterFetcher.new(@query, from_id: @from_id).fetch if @query&.size > 0

  slim :index
end
