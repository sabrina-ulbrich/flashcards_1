class Level < ActiveRecord::Base
	belongs_to :card
	belongs_to :user
	validates :card_id, presence: true
	validates :user_id, presence: true
end
