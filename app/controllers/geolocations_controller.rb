class GeolocationsController < ApplicationController
  def create
    # probably won't be used anyway
    #if @user = current_user
    #  @user.geolocations.where(:lat => params[:lat], :lng => params[:lng]).first_or_create!
    #end

    store_in_session(params)

    results = Geocoder.search("#{session[:lat]},#{session[:lng]}")

    if results
      store_in_session(address: results.first.formatted_address)
    end

    render :json => session.to_json
  end

  def search
    search = params[:search]

    results = Geocoder.search(search)
    if results
      result = results.first
      store_in_session(
          {
              :lat => result.latitude,
              :lng => result.longitude,
              :address => result.formatted_address
          })
    end

    render :json => session.to_json
  end

  private
  def store_in_session(params = {})
    [:lat, :lng, :address].each do |key|
      session[key] = params[key] if params[key]
    end
  end
end
