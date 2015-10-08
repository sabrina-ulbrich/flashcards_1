require 'rails_helper'

describe "CardsetPages" do
  let(:user) { create(:user) }

  subject { page }

  describe "new cardset page" do
    before do
      sign_in user
      visit new_cardset_path
    end

    it { should have_content('Create a new set of cards') }
    # don't know full_title
    # it { should have_title(full_title('New set of cards')) }
  end

  describe "index cardset page" do
    before do
      @cardset1 = create(:cardset, topic: "T1")
      @cardset2 = create(:cardset, topic: "T2")
      sign_in user
      visit cardsets_path
    end

    it { should have_content(@cardset1.topic) }
    it { should have_content(@cardset2.topic) }
    it { should have_title('All cardsets') }
  end

  describe "edit cardset page" do
    let(:cardset) { create(:cardset) }

    describe "should not be accessible for uncorrect user" do
      before do
        sign_in user
        visit edit_cardset_path(cardset)
      end

      it { should_not have_content('Edit card set:') }
      # don't know full_title
      # it { should_not have_title(full_title('Edit card set')) }
      it { should have_selector('div.alert.alert-error', text:'You have to be owner of the cardset') }
    end

    describe "should be accessible only for the cardset owner" do
      before do
        cardset.update_attributes!(author: user)
        sign_in user
        visit edit_cardset_path(cardset)
      end

      it { should have_content('Edit card set:') }
      # don't know full_title
      # it { should have_title(full_title('Edit card set')) }
    end
  end
end
