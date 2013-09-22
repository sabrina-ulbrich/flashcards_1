class CardsetsController < ApplicationController
  before_action :signed_in_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @cardsets = Cardset.all
  end

  def new
    @cardset = Cardset.new
  end

  def create
    @cardset = Cardset.new(cardset_params.merge(author_id: current_user.id))
    if @cardset.save
      flash[:success] = "A new set of cards is created!"
      redirect_to @cardset
    else
      render 'new'
    end
  end

  def show
    @cardset = Cardset.find(params[:id])
    @cards = @cardset.cards.with_levels_for(current_user.id).group_by_level(current_user)   
  end

  def edit
    @cardset = Cardset.find(params[:id])
  end

  def update
    @cardset = Cardset.find(params[:id])
    if @cardset.update_attributes(cardset_params)
      flash[:success] = "The card set is updated!"
      redirect_to @cardset
    else
      render 'edit'
    end
  end

  def destroy
    @cardset.destroy
    redirect_to current_user
  end

  private
    def cardset_params
      params.require(:cardset).permit(:topic, :description)
    end

    def correct_user
      cardset = Cardset.find(params[:id])
      if cardset.author_id != current_user.id
        flash[:error] = "You have to be owner of the cardset!"
        redirect_to current_user
      end
    end
end