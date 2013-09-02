require 'spec_helper'

describe "CardsetPages" do
	
	subject { page }
  
  describe "new cardset page" do
  	let(:user) { FactoryGirl.create(:user) }
  	before do
  		sign_in user
  		visit new_cardset_path
  	end

    it { should have_content('Create a new set of cards') }
    it { should have_title(full_title('New set of cards')) }
  end

  describe "cardset page" do
  	let(:cardset) { FactoryGirl.create(:cardset) }
  	before { visit cardset_path(cardset) }

  	it { should have_content(cardset.topic) }
  	it { should have_title(cardset.topic) }
  	it { should have_content(cardset.user.name) }
  end
end