require 'rest-client'

class PagesController < ApplicationController

  def new
  end

  def index
    @pages = current_user.pages
  end

  def create
    url = params[:page][:url]
    speed = params[:page][:speed].to_i

    @page = Page.create(:url => url, :user_id => current_user.id)
    job_id = WordScheduler.start(@page, speed)
    session[:job] = job_id

  rescue Exceptions::InvalidURL => e
    @message = e.message
    respond_to do |format|
      format.js { render "invalid" }
    end
  end

  def pause
    WordScheduler.pause(session[:job])
    render nothing: true
  end

  def resume
    WordScheduler.resume(session[:job])
    render nothing: true
  end

end
