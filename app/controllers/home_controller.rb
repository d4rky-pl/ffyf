class HomeController < ApplicationController
  before_filter :prepare_address

  def prepare_address
    @current_address = session[:address] if session[:address]
  end

  def mosaic
    @display_type = :mosaic
    @places = session[:lat] && session[:lng] ? Place.includes(:photos).closest_to(session[:lat], session[:lng]).limit(1000) : Place.none
    @photos = @places.map { |place| place.photos }.flatten.sort_by { rand }
    check_results(@places)
    render 'index'
  end

  def list
    @display_type = :list
    @places = session[:lat] && session[:lng] ? Place.includes(:photos).closest_to(session[:lat], session[:lng]).limit(1000) : Place.none
    check_results(@places)
    render 'index'
  end

  def map
    @map_data = if session[:lat] && session[:lng]
                  places = Place.includes(:latest_photo).close_to(session[:lat], session[:lng]).limit(1000)
                  if places.empty?
                    [{:lat => session[:lat], :lng => session[:lng]}].to_json
                  else
                    places.to_gmaps4rails do |place, marker|
                      marker.infowindow render_to_string(:partial => "marker_template", :locals => {:place => place})
                    end
                  end
                else
                  # manhattan
                  Place.includes(:latest_photo).close_to(40.7902778, -73.9597222).limit(1000).to_gmaps4rails do |place, marker|
                    marker.infowindow render_to_string(:partial => "marker_template", :locals => {:place => place})
                  end
                end
    @display_type = :map
    render 'index'
  end

  def place
    @place = Place.find(params[:id])
    @map_data = @place.to_gmaps4rails
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
      job_id = InstagramFetcherWorker.perform_async(session[:lat], session[:lng])

      flash[:job_id] = job_id
    end
  end
end
