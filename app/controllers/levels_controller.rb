class LevelsController < ApplicationController

  def new
    @cardset = Cardset.find(params[:cardset_id])
    @card = Card.find(params[:card_id])
    @level = Level.new
  end

  def create
    card = Card.find(params[:card_id])
    cardset = card.cardset

    if params[:commit] == "correct"
      flash[:success] = "The card raises its level!"
      status = 1
    elsif params[:commit] == "false"
      flash[:notice] = "The card stays on the same level."
      status = 0
    end

    sort_order = cardset.max_order(status, current_user.id) + 1
    card.levels.create(:status => status, :user_id => current_user.id, :sort_order => sort_order)
    
    next_card = cardset.cards.with_levels_for(current_user.id).with_status(0).first
    level = next_card.level_for_user(current_user)

    if next_card and !level
      redirect_to new_cardset_card_level_path(cardset, next_card)
    elsif next_card
      redirect_to edit_cardset_card_level_path(cardset, next_card, level)
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
    @level = Level.find(params[:id])
    
    current_status = @level.status
    if params[:commit] == "correct"
      @level.status += 1
    elsif params[:commit] == "false"
      @level.status = 0
    end
    
    @level.sort_order = cardset.max_order(@level.status, current_user.id) + 1
    @level.save
    
    @card = cardset.cards.with_levels_for(current_user.id).with_status(current_status).first
    if @card
      redirect_to edit_cardset_card_level_path(cardset, @card, @card.level_for_user(current_user))
    else
      redirect_to cardset_path(cardset)
    end
  end
end