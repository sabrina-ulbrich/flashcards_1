class Level < ActiveRecord::Base
	belongs_to :card
	belongs_to :user
	validates :card_id, presence: true
	validates :user_id, presence: true

	def raise_status
		status += 1
	end

	def reset_status
		status = 0
	end
end
