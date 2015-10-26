class Competition
	include Dynamoid::Document
	table :name => :competitions, :key => :id, :read_capacity => 5, :write_capacity => 5
	field :title, :string
	field :description, :string
	field :start_date, :string 
	field :end_date, :string 
	field :uri, :string 
	field :user_id, :string 
	field :image, :string 

	validates :title, presence: true, length: { minimum: 5 }
	validates :description, presence: true
	validates :start_date, presence: true
	validates :end_date, presence: true
	validates :uri, presence: true
	#validates_uniqueness_of :uri
	mount_uploader :image, ImageUploader
	has_many :videos
	belongs_to :user
end
