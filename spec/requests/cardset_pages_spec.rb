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

  describe "index cardset page" do
    
    before do
      @cardset1 = FactoryGirl.create(:cardset, id: 1, topic: "T1")
      @cardset2 = FactoryGirl.create(:cardset, id: 2, topic: "T2")
      visit cardsets_path
    end

    xit { should have_content(@cardset1.topic) }
    xit { should have_content(@cardset2.topic) }
    xit { should have_title('All cardsets') }
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
        user = cardset.create_author!(name: 'name', email: 'user_1@examle.com', password: 'password', password_confirmation: 'password')
        p cardset.author
        sign_in cardset.author
        visit edit_cardset_path(cardset)
      end

      xit { should have_content('Edit card set:') }
      xit { should have_title(full_title('Edit card set')) }
    end
  end
end