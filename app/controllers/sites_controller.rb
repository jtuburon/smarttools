class SitesController < ApplicationController
	include VideosHelper
	def index
		@competition = Competition.find_by_uri(params[:uri])
		if @competition	!= nil			
			@video = Video.new			
			all_converted_videos_in_competition(@competition)
			respond_to do |format|
				format.html
				format.js
  			end			
		end 
	end
end
