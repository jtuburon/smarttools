class User
	include Dynamoid::Document
	table :name => :users, :key => :id, :read_capacity => 5, :write_capacity => 5
	field :name, :string
	field :lastname, :string
	field :email, :string 
	field :password_salt, :string 
	field :password_hash, :string 
	
	attr_accessor :password
 	before_save :encrypt_password
  	
	validates :name, presence: true, length: { minimum: 5 }
	validates :lastname, presence: true
	validates :password, presence: true, confirmation: true
	validates :password_confirmation, presence: true
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }	
  	#validates_uniqueness_of :email
  	
	def self.authenticate(email, password)
	    user = find_by_email(email)
	    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
	      user
	    else
	      nil
	    end
	end
  
	def encrypt_password
		if password.present?
			self.password_salt = BCrypt::Engine.generate_salt
			self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)	
		end
	end  	
end
