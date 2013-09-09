require 'spec_helper'

describe Cardset do
  let(:user) { FactoryGirl.create(:user) }
  let(:cardset) { user.cardsets.build(topic: "Topic", description: "Description") }

  subject { cardset }

  it { should respond_to(:topic) }
  it { should respond_to(:description) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }
  it { should respond_to(:cards) }

  it { should be_valid }

  describe "when user_id is not present" do
  	before { cardset.user_id = nil }
  	it { should_not be_valid }
  end

	describe "when topic is not present" do
		before { cardset.topic = nil }
		it { should_not be_valid }
	end

  describe "max_order should return last sort_order" do
    let(:cardset) { user.cardsets.create(topic: "Topic", description: "Description") }
    let(:card) { cardset.cards.create(question: "Question", answer: "Answer") }

    describe "given no level exists" do
      it { cardset.max_order(1, card.cardset.user_id).should eq(0) }
    end

    describe "given a level exists" do
      before do
        card.create_level(status: 1, sort_order: 1, user: card.cardset.user)
      end

      it { cardset.max_order(1, card.cardset.user_id).should eq(1) }
    end
  end
end
