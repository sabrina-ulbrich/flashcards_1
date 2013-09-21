require 'spec_helper'

describe Cardset do
  let(:cardset) { FactoryGirl.create(:cardset) }

  subject { cardset }

  it { should respond_to(:topic) }
  it { should respond_to(:description) }
  it { should respond_to(:author_id) }
  it { should respond_to(:cards) }

  it { should be_valid }

  describe "without author_id" do
    before { cardset.author_id = nil }
    it { should_not be_valid }
  end

  describe "without topic" do
    before { cardset.topic = nil }
    it { should_not be_valid }
  end

  describe ".max_order should return the last number of sort_order" do
    let(:card) { cardset.cards.create(question: "Question", answer: "Answer") }

    describe "when no level exists" do
      it { cardset.max_order(1, card.cardset.author_id).should eq(0) }
    end

    describe "when a level exists" do
      before do
        card.levels.create(status: 1, sort_order: 1, user_id: card.cardset.author_id)
      end

      it { cardset.max_order(1, card.cardset.author_id).should eq(1) }
    end
  end

  describe "destroy" do
    before do
      @cardset_2 = FactoryGirl.create(:cardset, id: 1, topic: "T1")
      @selection = @cardset_2.selections.create(user_id: 1, cardset_id: 1)
      @card = @cardset_2.cards.create(id: 1, cardset_id: 1, question: "Q1", answer: "A1")
      @card.levels.create(card_id: 1, user_id: 1, status: 1)
      @cardset_2.destroy
    end

    it "should destroy the associated selection" do
      Selection.find_by_cardset_id(@cardset_2.id).should be_nil
    end

    it "should destroy the cardset itself" do
      Cardset.find_by_id(@cardset_2.id).should be_nil
    end

    it "should destroy all associated cards, too" do
      Card.find_by_cardset_id(@cardset_2.id).should be_nil
    end

    it "should destroy all associated levels, too" do
      Level.find_by_card_id(@card.id).should be_nil
    end
  end
end
