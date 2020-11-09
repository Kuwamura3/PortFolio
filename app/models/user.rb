class User < ApplicationRecord
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
	devise :database_authenticatable, :registerable,
				 :recoverable, :rememberable, :validatable, :authentication_keys => [:name]

	has_many :relationships
	has_many :users_comments
	has_many :notifications
	has_many :users_games
	has_many :posts

	# emailカラムを使用しない
	def email_required?
		false
	end

	def email_changed?
		false
	end

	def will_save_change_to_email?
		false
	end

end
