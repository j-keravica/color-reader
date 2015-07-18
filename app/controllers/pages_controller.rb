class PagesController < ApplicationController

	def new
	end

	def create
		title = Nokogiri::HTML::Document.parse(HTTParty.get(params[:page][:url]).body).title
		#render plain: params[:page].inspect
		@user = current_user
		@page = Page.new(:url => params[:page][:url], :title => title, :text => "bla", :user_id => @user.id)
		@page.save
		redirect_to @page
	end

	def show
		@page = Page.find(params[:id])
	end
end
