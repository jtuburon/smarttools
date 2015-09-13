class AdminController < ApplicationController
	def index
		@competitions = Competition.all
		@competition = Competition.new
	end
end
