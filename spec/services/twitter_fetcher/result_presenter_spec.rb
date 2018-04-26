require File.expand_path '../../../spec_helper.rb', __FILE__

describe TwitterFetcher::ResultPresenter do
  let(:query) { 'cute capybara' }
  let(:max_id) { nil }
  let(:presenter) { TwitterFetcher.new(query, max_id: max_id).fetch }

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

    context 'tweets started from max_id' do
      let(:max_id) { 988849425010384896 }
      it do
        VCR.use_cassette('twitter_fetcher/results_presenter/tweets_found_with_max_id') do
          expect(subject.size).to eq(TwitterFetcher::PER_PAGE)
          expect(subject.first).to be_a Twitter::Tweet
          expect(subject.first.id).to eq(max_id)
        end
      end
    end
  end

  describe '#has_more?' do
    subject { presenter.has_more? }

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

  describe '#next_max_id' do
    subject { presenter.next_max_id }

    it do
      VCR.use_cassette('twitter_fetcher/results_presenter/tweets_found') do
        expect(subject).to eq(988849425010384895)
      end
    end
  end
end
