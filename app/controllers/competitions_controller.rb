class CompetitionsController < ApplicationController
	layout "main"
	protect_from_forgery
	before_action :all_competitions, only: [:index, :create, :update, :destroy]
  	before_action :set_competition, only: [:edit, :update, :destroy]

	def index
		@competition = Competition.new
	end

	def show
		@competition = Competition.find(params[:id])
		end

	def new
		@competition = Competition.new
	end
	def create
		@competition = Competition.new(new_competition_params)
		@competition.uri = SecureRandom.uuid	
		if @competition.save
			respond_to do |format|
				format.js { }
  			end
		else
	  		render 'new'
		end
	end

	def update
		@competition.update_attributes(update_competition_params)
	end

	def destroy
		@competition.destroy
	end

		private
			def new_competition_params
				params.require(:competition).permit(:title, :description, :start_date, :end_date, :image, :remote_image_url)
			end

			def update_competition_params
				params.require(:competition).permit(:title, :description, :start_date, :end_date, :uri, :image, :remote_image_url)
			end

			def all_competitions
	  			@competitions = Competition.all
		end

	def set_competition
	  @competition = Competition.find(params[:id])
	end
end
