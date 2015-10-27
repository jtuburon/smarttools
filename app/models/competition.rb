class Competition
	include Dynamoid::Document
	extend CarrierWave::Mount
	table :name => :competitions, :key => :id, :read_capacity => 5, :write_capacity => 5
	field :title, :string
	field :description, :string
	field :start_date, :string 
	field :end_date, :string 
	field :uri, :string 
	field :user_id, :string 
	field :image, :string
	field :image_s, :string


	attr_accessor :image

	validates :title, presence: true, length: { minimum: 5 }
	validates :description, presence: true
	validates :start_date, presence: true
	validates :end_date, presence: true
	validates :uri, presence: true
	#validates_uniqueness_of :uri

	#before_save :update_upload

	mount_uploader :image, ImageUploader
	has_many :videos
	belongs_to :user

	

	private
    def update_upload
    	#self.image = File.open("/home/teo/Downloads/Hadoop.jpg")	    	
    end
end
