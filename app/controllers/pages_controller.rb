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

    color = params[:page][:color]

    words = page.text.split
    num_of_times = words.length - 1

    scheduler = Rufus::Scheduler.new

    i = 0;
    wpm = params[:page][:speed].to_i
    puts "The calculated time is " + time(wpm.to_i)

    job_id =
    Rufus::Scheduler.singleton.every time(wpm), :times => num_of_times do
        RestClient.post(
            ENV['COLOR_URL'] + '/color',
            {:word => words[i],
            :color => color}
        )
        i += 1
        #puts i
    end

    puts "This happens after scheduler"
    session[:job] = job_id


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
