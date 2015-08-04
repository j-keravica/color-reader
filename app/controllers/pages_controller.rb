require 'open-uri'
require 'rest-client'

class PagesController < ApplicationController

  def new
  end

  def create
    url = params[:page][:url]
    begin
      extracted_page = PageExtractor.extract_page(url)
    rescue Exception => e
      @message = e.message
      respond_to do |format|   
        format.js { render "invalid" }
      end
      return
    end

    current_user.pages.create(:url => url, :title => extracted_page.title, :text => extracted_page.text)

    job_id = WordScheduler.start(params[:page][:speed].to_i, extracted_page.text.split, params[:page][:color])

    session[:job] = job_id
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
