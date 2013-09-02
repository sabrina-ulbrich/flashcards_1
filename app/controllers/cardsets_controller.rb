class CardsetsController < ApplicationController
	before_action :signed_in_user, only: [:new, :create, :edit, :update, :destroy]
	before_action :correct_user, only: [:edit, :update, :destroy]

	def index
	end

	def new
		@cardset = Cardset.new
	end

	def create
		@cardset = current_user.cardsets.build(cardset_params)
		if @cardset.save
			flash[:success] = "A new set of cards is created!"
			redirect_to @cardset
		else
			render 'new'
		end
	end

	def show
		@cardset = Cardset.find(params[:id])
	end

	def edit
		# Note the before_actions!
	end

	def update
		@cardset = Cardset.find(params[:id])
		if @cardset.update_attributes(cardset_params)
			flash[:success] = "Card Set updated"
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
			params.require(:cardset).permit(:topic, :description, :user_id)
		end

		def correct_user
			@cardset = current_user.cardsets.find_by_id(params[:id])
			redirect_to current_user if @cardset.nil?
		end
end