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

  describe "show cardset page" do
  	let(:cardset) { FactoryGirl.create(:cardset) }
  	before { visit cardset_path(cardset) }

  	it { should have_content(cardset.topic) }
  	it { should have_title(cardset.topic) }
  	xit { should have_content(cardset.user.name) }
  end

  describe "edit cardset page" do
    let(:cardset) { FactoryGirl.create(:cardset) }
    before { visit edit_cardset_path(cardset) }

    describe "should not be accessible for not-signed in user" do
      it { should_not have_content('Edit card set:') }
      it { should_not have_title(full_title('Edit card set')) }
    end

    describe "should be accessible only for the cardset owner" do
      before do
        sign_in cardset.user
        visit edit_cardset_path(cardset)
      end

      it { should have_content('Edit card set:') }
      it { should have_title(full_title('Edit card set')) }
    end
  end
end