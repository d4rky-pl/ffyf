class InstagramFetcherWorker
  include Sidekiq::Worker

  def perform(lat, lng)
    InstagramFetcher.get_foursquare_venues(lat, lng)
  end
end
