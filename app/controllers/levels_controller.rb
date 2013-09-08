class LevelsController < ApplicationController

	def new
		@cardset = Cardset.find(params[:cardset_id])
		@card = Card.find(params[:card_id])
		@level = Level.new
	end

	def create
		cardset = current_user.cardsets.find(params[:cardset_id])
		card = Card.find(params[:card_id])
		if params[:commit] == "correct"
			@level = card.create_level(:status => 1, :user_id => current_user.id)
			flash[:success] = "Card raises its level!"
		elsif params[:commit] == "false"
			@level = card.create_level(:status => 0, :tries => 1, :user_id => current_user.id)
		end
			@cards = cardset.cards.includes(:level).where(:levels => { :status => nil })
			redirect_to new_cardset_card_level_path(cardset, @cards.first)
	end

	def edit
		@cardset = Cardset.find(params[:cardset_id])
		@card = Card.find(params[:card_id])
		@level = Level.find(params[:level_id])
	end

	private
		def level_params
			params.require(:level).permit(:status, :card_id, :user_id)
		end
end