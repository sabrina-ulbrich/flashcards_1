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
        card.create_level(status: 1, sort_order: 1, user_id: card.cardset.author_id)
      end

      it { cardset.max_order(1, card.cardset.author_id).should eq(1) }
    end
  end
end
