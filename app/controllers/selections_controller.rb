class SelectionsController < ApplicationController

  def create
    current_user.selections.create(selection_params)
    flash.now[:success] = "The cardset was added to your collection."
    redirect_to current_user
  rescue ActiveRecord::RecordNotUnique => e
    flash[:error] = "The cardset already exists in your collection."
    redirect_to cardsets_path
  end

  private
    def selection_params
      params.require(:selection).permit(:cardset_id)
    end
end