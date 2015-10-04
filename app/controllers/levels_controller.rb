class LevelsController < ApplicationController

  def new
    @cardset = Cardset.find(params[:cardset_id])
    @card = Card.find(params[:card_id])
    @level = Level.new
  end

  def create
    card = Card.find(params[:card_id])
    cardset = card.cardset
    
    # learning a card the first time status is "2" if the answer is correct
    # otherwise "1" because of dissociation of created and not learned cards
    status = params[:commit] == 'correct' ? 2 : 1
    sort_order = cardset.max_order(status, current_user.id) + 1
    card.levels.create(:status => status, :user_id => current_user.id, :sort_order => sort_order)

    next_card = cardset.cards.with_levels_for(current_user.id).with_status(0).first
    if next_card
      redirect_to new_cardset_card_level_path(cardset, next_card)
    else
      redirect_to cardset_path(cardset)
    end
  end

  def edit
    @cardset = Cardset.find(params[:cardset_id])
    @card = Card.find(params[:card_id])
    @level = @card.level_for_user(current_user)
  end

  def update
    cardset = Cardset.find(params[:cardset_id])
    level = Level.find(params[:id])
    current_status = level.status
    level.status = params[:commit] == 'correct' ? level.status + 1 : 1
    level.sort_order = cardset.max_order(level.status, current_user.id) + 1
    level.save

    next_card = cardset.cards.with_levels_for(current_user.id).with_status(current_status).first
    if next_card
      redirect_to edit_cardset_card_level_path(cardset, next_card, next_card.level_for_user(current_user))
    else
      redirect_to cardset_path(cardset)
    end
  end
end
