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

    def has_next_page?
      !metadata[:next_results].nil?
    end

    def has_previous_page?
      since_id > 0
    end

    def max_id
      metadata[:max_id]
    end

    def since_id
      metadata[:since_id]
    end
  end
end
