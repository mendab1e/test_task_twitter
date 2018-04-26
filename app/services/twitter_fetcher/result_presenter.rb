class TwitterFetcher
  class ResultPresenter
    attr_reader :search_results, :error, :metadata

    def initialize(search_results: nil, error: nil)
      @search_results = search_results
      @error = error
      @metadata = search_results.attrs[:search_metadata] if search_results
    end

    def successful?
      error.nil?
    end

    def tweets
      search_results.take(TwitterFetcher::PER_PAGE)
    end

    def has_more?
      !metadata[:next_results].nil?
    end

    def next_max_id
      tweets.last.id - 1 if tweets.any?
    end
  end
end
