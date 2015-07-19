require 'open-uri'

class PagesController < ApplicationController

	def new
	end

	def create
		#title = Nokogiri::HTML::Document.parse(HTTParty.get(params[:page][:url]).body).title
		#render plain: params[:page].inspect
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
		redirect_to @page
	end

	def show
		@page = Page.find(params[:id])
	end
end
