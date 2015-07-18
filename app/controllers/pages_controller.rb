class PagesController < ApplicationController

	def new
	end

	def create
		render plain: params[:page].inspect
	end
end
