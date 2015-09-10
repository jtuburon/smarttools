class User < ActiveRecord::Base
	validates :name, presence: true, length: { minimum: 5 }
	validates :lastname, presence: true
	validates :password, presence: true
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }
	

end
