class Card < ActiveRecord::Base
  belongs_to :cardset
  has_many :levels, dependent: :destroy
  has_many :users, through: :levels
  validates :cardset_id,	presence: true
  validates :question,		presence: true
  validates :answer, 			presence: true

  def self.with_levels_for(user_id)    
    sql = sanitize_sql_array(['LEFT OUTER JOIN levels ON cards.id = levels.card_id AND levels.user_id = ?', user_id])
    cards = joins(sql).order_by_level
  end

  def self.with_status(status)
    status = [0, nil] if status.nil? || status == 0
    includes(:levels).where(:levels => { :status => status })
  end

  def self.order_by_level
    order('levels.status IS NOT NULL, levels.status, levels.sort_order IS NOT NULL, levels.sort_order, cards.id')
  end

  def self.group_by_level(user)
    all.group_by { |card| card.level_for_user(user).try(:status) || 0 }
  end

  def level_for_user(user)
    levels.where(user_id: user.id).first
  end
end
