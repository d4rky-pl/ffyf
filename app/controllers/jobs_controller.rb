class JobsController < ApplicationController
  def poll
    job = Delayed::Job.where(id: params[:id]).first
    if job
      render :json => {:job => 'not_ready'}
      return
    end
    render :json => {:job => 'done'}
  end
end