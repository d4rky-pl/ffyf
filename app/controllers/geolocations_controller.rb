class GeolocationsController < ApplicationController
  def create
    if @user = current_user
      @user.geolocations.where(:lat => params[:lat], :lng => params[:lng]).first_or_create!
    end

    session[:lat] = params[:lat]
    session[:lng] = params[:lng]

    # fixme: always?
    InstagramFetcher.delay.get_foursquare_venues(session[:lat], session[:lng])

    redirect_to :action => 'index'
  end

  def index
    render :json => session.to_json
  end

  def search
    search = params[:search]

    results = Geocoder.search(search)
    unless results
      result = results.first
      coordinates = Coordinates.new(result.latitude, result.longitude)
      CoordinatesStore.new(session).store(Coordinates)
    end
  end
end
