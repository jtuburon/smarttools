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
			registered_user = User.find_by_email(params[:user][:email].downcase)
			if registered_user && User.authenticate(params[:user][:email], params[:user][:password])
				session[:user_id] = registered_user.id
				render :js => "window.location = '/admin/index'"
			else
				@user.errors.add(:password, "Invalid email/password combination")
				render 'login'
			end
		else
			@user = User.new(user_params)
			print "#/////////////////////////////"
			print @user.name
			print "#/////////////////////////////\n"
			if @user.save	
				session[:user_id] = @user.id
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
