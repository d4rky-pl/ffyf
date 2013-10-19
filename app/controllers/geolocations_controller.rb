class GeolocationsController < ApplicationController
  def create
    if @user = current_user
      @user.geolocations.where(:lat => params[:lat], :lng => params[:lng]).first_or_create!
    end

    session[:lat] = params[:lat]
    session[:lng] = params[:lng]

    redirect_to :action => 'index'
  end

  def index
    render :json => session.to_json
  end
end
