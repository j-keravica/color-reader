require 'open-uri'
require 'rest-client'

class PagesController < ApplicationController

  def new
  end

  def index
    @pages = current_user.pages
  end

  def create
    url = params[:page][:url]
    extracted_page = PageExtractor.extract_page(url)
    current_user.pages.create(:url => url, :title => extracted_page.title, :text => extracted_page.text) unless current_user.nil?
    job_id = WordScheduler.start(params[:page][:speed].to_i, extracted_page.text.split, params[:page][:color])
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
