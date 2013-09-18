class CardsetsController < ApplicationController
  before_action :signed_in_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @cardsets = Cardset.all
    # @cardsets = Cardset.all - current_user.cardsets (2 arrays can be subtracted)
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
    # order_by_level.group_by_level
    @cards = @cardset.cards.with_levels_for(current_user.id).group_by_level
  end

  def edit
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
      #@cardset = current_user.cardsets.find_by_id(params[:id])
      redirect_to current_user unless @cardset.author_id == current_user.id
    end
end