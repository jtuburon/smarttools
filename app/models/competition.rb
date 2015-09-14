class Competition < ActiveRecord::Base
	validates :title, presence: true, length: { minimum: 5 }
	validates :description, presence: true
	validates :start_date, presence: true
	validates :end_date, presence: true
	validates :uri, presence: true
	validates_uniqueness_of :uri
	mount_uploader :image, ImageUploader
end
