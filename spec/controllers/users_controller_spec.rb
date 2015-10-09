require 'rails_helper'

describe UsersController do
  describe 'GET #new' do
    it "assigns a new User to @user" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end

    it "renders the :new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  # describe 'GET #edit' do
  #   # need a signed_in_user
  #   before :each do
  #     @user = create(:user)
  #     session[:user_id] = @user.id
  #   end
  #
  #   it "assigns the requested user to @user" do
  #     #user = create(:user)
  #     get :edit, id: @user.id
  #     expect(assigns(:user)).to eq @user.id
  #   end
  #
  #   it "renders the :edit template" do
  #     #user = create(:user)
  #     get :edit, id: @user.id
  #     expect(response).to render_template :edit
  #   end
  # end
end
