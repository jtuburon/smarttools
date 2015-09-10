class MainController < ApplicationController
	layout "main"
  def index
    @user = User.new
  end

  def admin
    
  end
end
