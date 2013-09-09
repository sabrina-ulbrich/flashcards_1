class Card < ActiveRecord::Base
	belongs_to :cardset
	has_one :level
	validates :cardset_id, presence: true

	def self.with_levels_for(user_id)
		includes(:level).where(:levels => { :user_id => [nil, user_id] })
	end

	def self.with_status(status)
		status = [0, nil] if status.nil? || status == 0
		includes(:level).where(:levels => { :status => status })
	end

	def self.order_by_level
		order('levels.status ASC, levels.sort_order ASC')
	end

	def self.group_by_level
		all.group_by { |card| card.level ? card.level.status : 0 }
	end
end
