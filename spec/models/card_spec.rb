require 'spec_helper'

describe Card do
  
  let(:cardset) { FactoryGirl.create(:cardset) }
  let(:card) { cardset.cards.build(question: "Question", answer: "Answer") }

  subject { card }

  it { should respond_to(:question) }
  it { should respond_to(:answer) }
  it { should respond_to(:cardset_id) }
  it { should respond_to(:cardset) }
  its(:cardset) { should eq cardset }

  it { should be_valid }

  describe "without cardset_id" do
  	before { card.cardset_id = nil }
  	it { should_not be_valid }
  end

  describe "without question" do
    before { card.question = " " }
    it { should_not be_valid }
  end

  describe "without answer" do
    before { card.answer = " " }
    it { should_not be_valid }
  end

  describe "when user_1 creates a cardset user_2 can learn this" do

    describe ".with_levels_for(user) should return cards with levels" do

      before do
        @user_1 = cardset.create_author!(name: 'name', email: 'user_1@examle.com', password: 'password', password_confirmation: 'password')
        @user_2 = FactoryGirl.create(:user, email: 'user_2@example.com')

        @cards = (1..3).to_a.map do |num|
          cardset.cards.create!(question: "question #{num}", answer: "answer #{num}")
        end

        @cards.first.create_level!(user: @user_1, status: 1)
      end

      it "should work" do
        cardset.cards.with_levels_for(@user_1.id).count.should eq(3)
      end

      it "should also work" do
        cardset.cards.with_levels_for(@user_2.id).count.should eq(3)
      end

      describe "when a card is destroyed" do
        before do
          @card_2 = cardset.cards.create(id: 1, question: "Q1", answer: "A1")
          @card_2.create_level(card_id: 1, user_id: 1, status: 1)
        end

        it "card should be destroyed" do
          @card_2.destroy
          Card.find_by_id(@card_2.id).should be_nil
        end

        it "all associated levels should be destroyed too" do
          @card_2.destroy
          Level.find_by_card_id(@card_2.id).should be_nil
        end
      end
    end
  end
end
