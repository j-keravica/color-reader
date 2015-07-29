require 'open-uri'
require 'rest-client'

class PagesController < ApplicationController

	def new
	end

	def create
		url = params[:page][:url]
		doc = Nokogiri::HTML(open(url))
		text = ""
		doc.xpath('//h1 | //p').each do |node|
	      	text = text + " " + node.text
	    end

	    title = doc.xpath('//title').text
		@user = current_user
		@page = Page.new(:url => url, :title => title, :text => text, :user_id => @user.id)
		@page.save

		color = params[:page][:color]
		#resource = RestClient::Resource.new(ENV['COLOR_URL'])
		#response1 = resource['/set/' + color].get
		#cookie = response1.cookies
		#puts cookie

	    words = text.split
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
