class SitesController < ApplicationController
	def index
		@competition = Competition.find_by_uri(params[:uri])
		if @competition	!= nil			
			#@videos= Video.where(["competition_id = ? and converted_at IS NOT NULL", @competition]);
			@videos= Video.where(competition: @competition);
		end 
	end
end
