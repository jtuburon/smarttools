class Video
	include Dynamoid::Document
	extend CarrierWave::Mount

	table :name => :videos, :key => :id, :read_capacity => 5, :write_capacity => 5
	field :message, :string
	field :user_name, :string
	field :user_lastname, :string 
	field :o_video, :serialized 
	field :c_video, :serialized 
	field :converted_at, :datetime 
	field :user_email, :string 
	field :competition_id, :string
	field :status, :integer
	
	attr_accessor :o_video

	belongs_to :competition
	validates :message, presence: true
	validates :user_name, presence: true
	validates :user_lastname, presence: true
	validates :message, presence: true
	validates :o_video, presence: true
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :user_email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }	
	#enum status: {in_process: 0, converted: 1 }
	mount_uploader :o_video, VideoUploader
end
