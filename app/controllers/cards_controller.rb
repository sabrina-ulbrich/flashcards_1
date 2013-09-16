class CardsController < ApplicationController

	def index
		@cards = Cardset.find(params[:cardset_id]).cards
	end

	def new
		@cardset = Cardset.find(params[:cardset_id])
		@card = Card.new
	end

	def create
		@cardset = Cardset.find(params[:cardset_id])
		@card = @cardset.cards.build(card_params)
		if @card.save
			flash[:success] = "A new card is created!"
			redirect_to cardset_card_path(@card.cardset_id, @card.id)
		else
			render 'new'
		end
	end

	def show
		@cardset = Cardset.find(params[:cardset_id])
		@card = Card.find(params[:id])
	end

	def edit
		@cardset = Cardset.find(params[:cardset_id])
		@card = Card.find(params[:id])
	end

	def update
		@cardset = Cardset.find(params[:cardset_id])
		@card = Card.find(params[:id])
		if @card.update_attributes(card_params)
			flash[:success] = "Card is updated!"
			redirect_to cardset_card_path(@card.cardset_id, @card.id)
		else
			render 'edit'
		end
	end

	def destroy
		@card = Card.find(params[:id])
		@card.destroy
		redirect_to current_user
	end

	private
		def card_params
			params.require(:card).permit(:question, :answer, :cardset_id)
		end
end