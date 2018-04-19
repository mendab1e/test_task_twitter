class TwitterFetcher
  attr_reader :query, :page

  def initialize(query, page: 1)
    @query = query
    @page = page
  end

  def fetch
    %w(stub1 stub2 stub3)
  end
end
