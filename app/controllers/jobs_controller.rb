class JobsController < ApplicationController
  def poll
    if Sidekiq::Status::queued?(params[:id]) || Sidekiq::Status::working?(params[:id])
      render :json => {:job => 'not_ready'}
      return
    end
    render :json => {:job => 'done'}
  end
end