class Card < ActiveRecord::Base
  belongs_to :cardset
  has_one :level, dependent: :destroy
  validates :cardset_id,	presence: true
  validates :question,		presence: true
  validates :answer, 			presence: true

  def self.with_levels_for(user_id)
    # joins(sql).where(levels: { user_id: [user_id, nil] })
    # result = scoped
    # ActiveRecord::Associations::Preloader.new(result, [:level], conditions: [sql]).run
    # result
    # cards = all
    # ActiveRecord::Associations::Preloader.new(cards, [:level]).run
    # cards
    sql = sanitize_sql_array(['LEFT OUTER JOIN levels ON cards.id = levels.card_id AND levels.user_id = ?', user_id])
    cards = joins(sql)
    cards = cards.order('levels.status IS NOT NULL, levels.status, levels.sort_order IS NOT NULL, levels.sort_order, cards.id')

    levels = Level.where(user_id: user_id, card_id: cards.map(&:id)).load
    cards.load.each do |card| 
      card.level = levels.detect { |level| level.card_id == card.id }
    end
    cards
  end

  def self.with_status(status)
    status = [0, nil] if status.nil? || status == 0
    includes(:level).where(:levels => { :status => status })
  end

  def self.group_by_level
    all.group_by { |card| card.level ? card.level.status : 0 }
  end
end
