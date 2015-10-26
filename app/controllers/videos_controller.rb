class VideosController < ApplicationController
	layout "main"
	include VideosHelper, SqsHelper
	protect_from_forgery
  	before_action :set_video, only: [:edit, :update, :destroy]

 	def index
 		if !session[:user_id]
			redirect_to root_path
		else
			@video = Video.new
			print params
			@competition= Competition.find_by_id(params[:id])
			@video.competition_id= @competition.id
			all_videos_in_competition(params[:id])
		end		
	end

 	def timeline
 		if !session[:user_id]
			redirect_to root_path
		else
			@video = Video.new
			@competition= Competition.find_by_uri(params[:uri])
			@video.competition_id= @competition.id
			all_converted_videos_in_competition(@competition)
		end		
	end

	def new
		@video = Video.new
		print params
		@competition= Competition.find_by_id(params[:competition])
		@video.competition_id= @competition.id
	end

	def create
		@video = Video.new(video_params)	
		vid = params[:video][:o_video]
		@video.o_video  = vid

		if @video.save
			print "############"
			print @video.competition_id
			print "############"
			@competition= Competition.find_by_id(@video.competition_id)
			# Send the video id to the queue
			send_msg_to_queue(@video.id.to_s)
			all_converted_videos_in_competition(@video.competition_id)			
			respond_to do |format|
				format.js {render "videos/create.js", :locals => {:id => @video.competition_id} }
  			end
		else
	  		render 'new'
		end
	end

	def preview
		@video = Video.find(params[:id])
		if params[:type]== 'O'
			@video_url = @video.o_video.url
		else
			@video_url = @video.c_video
		end
	end

		private
			def video_params
				params.require(:video).permit(:message, :user_name, :user_lastname, :user_email, :competition_id, :o_video, :remote_o_video_url)
			end
	  			
			def all_videos_in_competition(id)
	  			@videos= Video.where(competition_id: @competition.id)
	  			#@videos= Video.where(competition: id).order('created_at DESC').paginate(:page => params[:page], :per_page => 2)
	  		end		
end