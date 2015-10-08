require 'rails_helper'

describe "LearningPages" do
  let(:user) 		{ create(:user) }
  let(:cardset) { create(:cardset) }

  let(:cards) do
    (1..6).to_a.map do | num |
      cardset.cards.create!(question: "question #{num}", answer: "answer #{num}")
    end
  end

  subject { page }

  describe "Correct card order" do
    let!(:level_1) { cards.first.levels.create!(user: user, status: 2, sort_order: 1) }
    let!(:level_2) { cards.second.levels.create!(user: user, status: 1, sort_order: 1) }
    let!(:level_3) { cards.third.levels.create!(user: user, status: 1, sort_order: 3) }
    let!(:level_5) { cards.fifth.levels.create!(user: user, status: 1, sort_order: 2) }
    # cards.fourth and sixth without levels

    before { sign_in user }

    it "when the user learns new cards with level 0" do
      visit new_cardset_card_level_path(cardset, cards.fourth)
      should have_content('question 4')
      # click_button 'Show answer' not necessary because all html is shown for capybara
      click_on 'false'
      should have_content('question 6')
      click_button 'correct'
      should have_content('Overview')
    end

    it "when the user learns cards with level 1" do
      visit edit_cardset_card_level_path(cardset, cards.second, level_2)
      should have_content('question 2')
      click_button 'false'
      should have_content('question 5')
      click_button 'correct'
      should have_content('question 3')
      click_button 'correct'
      should have_content('question 2')
      click_button 'correct'
      should have_content('Overview')
    end
  end
end
