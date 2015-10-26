class Video
	include Dynamoid::Document

	belongs_to :competition
	validates :message, presence: true
	validates :user_name, presence: true
	validates :user_lastname, presence: true
	validates :message, presence: true
	validates :o_video, presence: true
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :user_email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }	
	enum status: {in_process: 0, converted: 1 }
	mount_uploader :o_video, VideoUploader
end
