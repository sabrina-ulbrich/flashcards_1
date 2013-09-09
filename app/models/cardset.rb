class Cardset < ActiveRecord::Base
	belongs_to :user # author
	has_many :cards
	validates :user_id, presence: true
	validates :topic,		presence: true

	def max_order(status, user_id)
		cards.joins(:level).where(levels: { status: status, user_id: user_id }).maximum(:sort_order) || 0
	end
end