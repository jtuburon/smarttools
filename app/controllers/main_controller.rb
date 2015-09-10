class MainController < ApplicationController
	layout "main"
  def index
    @user = User.new
  end
end
