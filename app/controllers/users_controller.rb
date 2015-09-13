class UsersController < ApplicationController
	before_action :all_users, only: [:index, :create, :update, :destroy]
	before_action :set_user, only: [:edit, :update, :destroy]

	def main
		@user = User.new
	end

	def show
		@user = User.find(params[:id])
	end

	def new
		@user = User.new
	end
	def create
		@user = User.new
		if params[:commit] == 'Iniciar'
			registered_user = User.find_by(email: params[:user][:email].downcase)
			if registered_user && User.authenticate(params[:user][:email], params[:user][:password])
				render :js => "window.location = '/admin/index'"
			else
				@user.errors.add(:email, "Invalid email/password combination")
				render 'new'
			end
		else
			@user = User.new(user_params)
			if @user.save
				render :js => "window.location = '/admin/index'"
			else
				render 'new'
			end	
		end
	end

	def update
		@user.update_attributes(user_params)
	end

	def destroy
		@user.destroy
	end

	private
	def user_params
		params.require(:user).permit(:name, :lastname, :email, :password, :password_confirmation)
	end

	def all_users
		@users = User.all
	end

	def set_user
		@user = User.find(params[:id])
	end

end
