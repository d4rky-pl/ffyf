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
    @map_data = if session[:lat] && session[:lng]
                  Place.close_to(session[:lat], session[:lng]).to_gmaps4rails do |place, marker|
                    marker.infowindow render_to_string(:partial => "marker_template", :locals => {:place => place})
                  end
                else
                  []
                end
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
    place.likes = place.likes + 1
    place.save!
    render :json => place.likes.to_json
  end

  # copy-past da best
  def dislike_place
    place = Place.find(params[:id])
    place.dislikes = place.dislikes + 1
    place.save!
    render :json => place.dislikes.to_json
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
    if result_set.length < 5 && session[:lat] && session[:lng] && flash[:from_search]
      # fixme: always?
      job = InstagramFetcher.delay.get_foursquare_venues(session[:lat], session[:lng])

      flash[:job_id] = job.id
    end
  end
end
