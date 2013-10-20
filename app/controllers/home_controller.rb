class HomeController < ApplicationController

  def mosaic
    @display_type = :mosaic
    @places = Place.closest_to(session[:lat], session[:lng])
    @photos = @places.map { |place| place.photos }.flatten.sort_by { rand }
    check_results(@places)
    render 'index'
  end

  def list
    @display_type = :list
    @places = Place.closest_to(session[:lat], session[:lng])
    check_results(@places)
    render 'index'
  end

  def map
    @map_data = session[:lat] && session[:lng] ? Place.close_to(session[:lat], session[:lng]).to_gmaps4rails : []
    @display_type = :map
    check_results(@map_data)
    render 'index'
  end

  def place
    @place = Place.find(params[:id])
  end

  # TODO: move some content to before filter
  def like_place
    place = Place.find(params[:id])

  end

  def dislike_place

  end

  #helper_method :photos
  #def photos
  #  # cache for design purpose (until we implement everything properly)
  #  unless @photos
  #    @photos = InstagramFetcher.get_by_tag("burger", { :since => (Time.now - 5.hour) })
  #    @photos.delete_if { |photo| photo.location.nil? || photo.location.name.nil? }
  #    @photos.map! do |photo|
  #      {
  #        :src => photo.images.standard_resolution.url,
  #        :author => photo.user.username,
  #        :desc => photo.caption.text,
  #        :link => photo.link
  #      }
  #    end
  #  end
  #  @photos
  #end

  private
  def check_results(result_set, min=5)
    if result_set.length < 5
      # fixme: always?
      InstagramFetcher.delay.get_foursquare_venues(session[:lat], session[:lng])

      flash[:search] = true
    end
  end
end
