class Video < ActiveRecord::Base
	belongs_to :competition
	enum status: {in_process: 0, converted: 1 }
end
