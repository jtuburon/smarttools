class AdminController < ApplicationController
	def index
		if !session[:user_id]
			redirect_to root_path
		else
			print session[:user_id]

			@competitions = Competition.where(user_id: session[:user_id])
			
			print @competitions
			@competition = Competition.new		
		end
	end
	def logout
		session.delete(:user_id)
		@current_user = nil
		redirect_to root_path
	end
end
