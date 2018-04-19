# myapp.rb
require 'sinatra'
require 'sinatra/reloader'
require_relative 'app/services/twitter_fetcher.rb'

get '/' do
  @query = params[:query]
  @page = params[:page]
  @tweets = TwitterFetcher.new(@query, page: @page).fetch if @query&.size > 0

  slim :index
end
