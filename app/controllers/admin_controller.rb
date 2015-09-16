class AdminController < ApplicationController
	def index
		if !session[:user_id]
			redirect_to root_path
		else
			@competitions = Competition.where(user: current_user)
			@competition = Competition.new		
		end
	end
	def logout
		session.delete(:user_id)
		@current_user = nil
		redirect_to root_path
	end
end
