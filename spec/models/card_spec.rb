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

    before do
      @user_1 = cardset.create_author!(name: 'name', email: 'user_1@examle.com', password: 'password', password_confirmation: 'password')
      @user_2 = FactoryGirl.create(:user, email: 'user_2@example.com')

      @cards = (1..3).to_a.map do |num|
        cardset.cards.create!(question: "question #{num}", answer: "answer #{num}")
      end

      @cards.first.levels.create!(user: @user_1, status: 1, sort_order: 0)
      @cards.second.levels.create!(user: @user_1, status: 0, sort_order: 1)      
  end

    it ".with_levels_for(user_1) should return cards with levels" do
      cardset.cards.with_levels_for(@user_1.id).count.should eq(3)
    end

    it ".with_levels_for(user_2) should also return the same cards" do
      cardset.cards.with_levels_for(@user_2.id).count.should eq(3)
    end

    it ".with_levels_for(user_1).with_status(1) should return one card" do
      cardset.cards.with_levels_for(@user_1.id).with_status(1).count.should eq(1)
    end

    it ".with_levels_for(user_2).with_status(1) should return no card" do
      cardset.cards.with_levels_for(@user_2.id).with_status(1).count.should eq(0)
    end

    it ".with_levels_for(user_2).with_status(0) should return three cards" do
      cardset.cards.with_levels_for(@user_2.id).with_status(0).count.should eq(3)
    end

    it ".with_levels_for(user_1) should return the correct order" do
      # ordered_ids = cardset.cards.with_levels_for(@user_1.id).map { |card| card.id }
      ordered_ids = cardset.cards.with_levels_for(@user_1.id).map(&:id)
      ordered_ids.should eq([@cards[2].id, @cards[1].id, @cards[0].id])
    end

    it ".with_levels_for(user_2) should return the correct order" do
      ordered_ids = cardset.cards.with_levels_for(@user_2.id).map(&:id)
      ordered_ids.should eq([@cards[0].id, @cards[1].id, @cards[2].id])
    end

    it ".with_levels_for(user_1).group_by_level should return correct groups" do
      ordered_hash = cardset.cards.with_levels_for(@user_1.id).group_by_level(@user_1.id)  		
      ordered_hash.should eq({ 0 => [@cards[2], @cards[1]], 1 => [@cards[0]] })
    end

    it ".with_levels_for(user_2).group_by_level should return correct groups" do
      cards = cardset.cards.with_levels_for(@user_2.id)
      cards.group_by_level(@user_2.id).should eq({ 0 => [@cards[0], @cards[1], @cards[2]] })
    end

    it "when 2 users learn a cardset both should be saved in levels" do
      @cards.first.levels.create!(user: @user_2, status: 1, sort_order: 2)
      @cards.second.levels.create!(user: @user_2, status: 0, sort_order: 0)
      @cards.third.levels.create!(user: @user_2, status: 1, sort_order: 1)
  
      cards = cardset.cards.with_levels_for(@user_2.id)
      cards.group_by_level(@user_2.id).should eq({ 0 => [@cards[1]], 1 => [@cards[2], @cards[0]] })
    end
  end
  
  describe "destroy" do
    before do
      @card_2 = cardset.cards.create(id: 1, question: "Q1", answer: "A1")
      @card_2.levels.create(card_id: 1, user_id: 1, status: 1)
      @card_2.destroy
    end

    it "should destroy the card itself" do
      Card.find_by_id(@card_2.id).should be_nil
    end

    it "should destroy all associated levels, too" do
      Level.find_by_card_id(@card_2.id).should be_nil
    end
  end

  describe ".with_status(status)" do
    before do
      @card_2 = cardset.cards.create(id: 2, question: "Q1", answer: "A1")
      @card_2.levels.create(card_id: 2, user_id: 1, status: 2)
      @card_3 = cardset.cards.create(id: 3, question: "Q1", answer: "A1")
      @card_3.levels.create(card_id: 3, user_id: 1, status: 2)
    end

    it "should return all cards with the requested status" do
      cardset.cards.with_status(2).should include(@card_2, @card_3)
    end

    it "should not return cards with another status" do
      cardset.cards.with_status(3).should_not include(@card_2, @card_3)
    end
  end
end