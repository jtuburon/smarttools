class VideosController < ApplicationController
	layout "main"
	protect_from_forgery
  	before_action :set_video, only: [:edit, :update, :destroy]

 	def index
		@video = Video.new
		@competition= Competition.find(params[:id])
		@video.competition= @competition
		all_videos_in_competition(params[:id])
	end

	def show
		@video = Video.find(params[:id])
	end

	def new
		@video = Video.new
		@competition= Competition.find(params[:competition])
		@video.competition= @competition
	end

	def create
		@video = Video.new(video_params)		
		if @video.save
			all_videos_in_competition(@video.competition_id)			
			respond_to do |format|
				format.js {render "videos/create.js", :locals => {:id => @video.competition_id} }
  			end
		else
	  		render 'new'
		end
	end

	def update
		@video.update_attributes(video_params)
	end

	def destroy
		@video.destroy
	end

		private
			def video_params
				params.require(:video).permit(:message, :user_name, :user_lastname, :user_email, :competition_id)
			end
	  			
			def all_videos_in_competition(id)
	  			@videos= Video.where(competition: id).order('created_at DESC').paginate(:page => params[:page], :per_page => 2)
	  		end
		

	def set_video
		@video = Video.find(params[:id])
	end
end