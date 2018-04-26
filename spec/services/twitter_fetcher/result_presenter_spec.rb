require File.expand_path '../../../spec_helper.rb', __FILE__

describe TwitterFetcher::ResultPresenter do
  let(:query) { 'cute capybara' }
  let(:from_id) { nil }
  let(:presenter) { TwitterFetcher.new(query, from_id: from_id).fetch }

  describe '#tweets' do
    subject { presenter.tweets }

    context 'tweets are found' do
      it do
        VCR.use_cassette('twitter_fetcher/results_presenter/tweets_found') do
          expect(subject.size).to eq(TwitterFetcher::PER_PAGE)
          expect(subject.first).to be_a Twitter::Tweet
        end
      end
    end

    context 'tweets are not found' do
      let(:query) { 'kfjsdnewqurewoue28712389fdckvdfaj' }

      it do
        VCR.use_cassette('twitter_fetcher/results_presenter/tweets_not_found') do
          expect(subject.size).to eq(0)
        end
      end
    end
  end

  describe '#has_next_page?' do
    subject { presenter.has_next_page? }

    context 'next page exists' do
      it do
        VCR.use_cassette('twitter_fetcher/results_presenter/tweets_found') do
          expect(subject).to eq(true)
        end
      end
    end

    context 'next page doesnt exist' do
      let(:query) { 'kfjsdnewqurewoue28712389fdckvdfaj' }

      it do
        VCR.use_cassette('twitter_fetcher/results_presenter/tweets_not_found') do
          expect(subject).to eq(false)
        end
      end
    end
  end

  describe '#has_previous_page?' do
    subject { presenter.has_previous_page? }

    context 'previous page exists' do
      it do
        VCR.use_cassette('twitter_fetcher/results_presenter/tweets_found') do
          expect(subject).to eq(false)
        end
      end
    end

    context 'previous doesnt exist' do
      let(:from_id) { 989486102154182657 }

      it do
        VCR.use_cassette('twitter_fetcher/results_presenter/tweets_found_2_page') do
          expect(subject).to eq(true)
        end
      end
    end
  end

  describe '#max_id' do
    subject { presenter.max_id }

    it do
      VCR.use_cassette('twitter_fetcher/results_presenter/tweets_found') do
        expect(subject).to eq(989486102154182657)
      end
    end
  end

  describe '#since_id' do
    subject { presenter.since_id }

    it do
      VCR.use_cassette('twitter_fetcher/results_presenter/tweets_found') do
        expect(subject).to eq(0)
      end
    end
  end
end
