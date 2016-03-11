class User < ActiveRecord::Base
	has_many :microposts
	validates :name, length: { maximum: 24 }, presence: true
	validates :email, presence: true
	validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
end
