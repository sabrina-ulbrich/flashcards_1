class Card < ActiveRecord::Base
	belongs_to :cardset
	validates :cardset_id, presence: true
end
