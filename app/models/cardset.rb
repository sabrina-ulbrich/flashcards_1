class Cardset < ActiveRecord::Base
  belongs_to :author, class_name: 'User'
  has_many :cards,      dependent: :destroy
  has_many :selections, dependent: :destroy
  has_many :users, through: :selections
  validates :author_id, presence: true
  validates :topic,     presence: true

  def max_order(status, user_id)
    cards.joins(:levels).where(levels: { status: status, user_id: user_id }).maximum(:sort_order) || 0
  end
end