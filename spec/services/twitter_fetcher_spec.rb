require File.expand_path '../../spec_helper.rb', __FILE__

describe TwitterFetcher do
  describe '#fetch' do
    let(:query) { 'cute capybara' }

    subject { described_class.new(query).fetch }

    context 'without error' do
      it do
        VCR.use_cassette('twitter_fetcher/without_error') do
          expect(subject).to be_a TwitterFetcher::ResultPresenter
          expect(subject.successful?).to be true
        end
      end
    end

    context 'with error' do
      it do
        VCR.use_cassette('twitter_fetcher/with_error') do
          expect(subject).to be_a TwitterFetcher::ResultPresenter
          expect(subject.successful?).to be false
        end
      end
    end
  end
end
