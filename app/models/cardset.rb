class Cardset < ActiveRecord::Base
	belongs_to :user
	validates :user_id, presence: true
	validates :topic,		presence: true
end