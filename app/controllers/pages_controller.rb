require 'open-uri'
require 'rest-client'

class PagesController < ApplicationController

  def new
  end

  def create
    url = params[:page][:url]
    page = PageExtractor.new(url)
    @page = Page.new(:url => url, :title => page.title, :text => page.text, :user_id => current_user.id)
    @page.save

    scheduler = WordScheduler.new(params[:page][:speed].to_i, page.text.split, params[:page][:color])
    scheduler.start_sending

    session[:job] = scheduler.job_id
  end

  def show
    @page = Page.find(params[:id])
  end

  def pause
    puts "pause"
    job_id = session[:job]
    job = Rufus::Scheduler.singleton.job(job_id)
    if !job.paused?
      job.pause
    end
    render nothing: true
  end

  def resume
    puts "resume"
    job_id = session[:job]
    job = Rufus::Scheduler.singleton.job(job_id)
    if job.paused?
      job.resume
    end
    render nothing: true
  end

  private
  def time(wpm)
    (60.0/wpm).round(1).to_s + 's'
  end

end
