require_relative 'twitter_fetcher/result_presenter'

class TwitterFetcher
  PER_PAGE = 10

  require 'twitter'
  attr_reader :query, :max_id

  def initialize(query, max_id: nil)
    @query = query
    @max_id = max_id
  end

  def fetch
    ResultPresenter.new(search_results: request_tweets)
  rescue => e
    ResultPresenter.new(error: e)
  end

  private

  def request_tweets
    client.search(query, count: PER_PAGE, max_id: max_id)
  end

  def client
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key    = ENV['CONSUMER_KEY']
      config.consumer_secret = ENV['CONSUMER_SECRET']
    end
  end
end
