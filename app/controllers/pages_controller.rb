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
	    #puts text.split
	    title = doc.xpath('//title').text
		@user = current_user
		@page = Page.new(:url => url, :title => title, :text => text, :user_id => @user.id)
		@page.save

		color = params[:page][:color]
		resource = RestClient::Resource.new('http://localhost:4567')
		response1 = resource['set/' + color].get
		cookie = response1.cookies
		puts cookie
		response2 = resource['color/blahblah'].get({:cookies => cookie})

		render nothing: true

	end

	def show
		@page = Page.find(params[:id])
	end

end
