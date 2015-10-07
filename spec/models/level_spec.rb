require 'rails_helper'

describe Level do

  let(:cardset) { FactoryGirl.create(:cardset) }
  let(:card) { cardset.cards.create(question: "Question", answer: "Answer") }
  let(:level) { card.levels.build(status: 0, user_id: card.cardset.author_id) }

  subject { level }

  it { should respond_to(:status) }
  it { should respond_to(:card_id) }
  it { should respond_to(:user_id) }
  it { should respond_to(:card) }
  it { should respond_to(:user) }

  it { should be_valid }

  describe "when card_id is not present" do
    before { level.card_id = nil }
    it { should_not be_valid }
  end

  describe "when user_id is not present" do
    before { level.user_id = nil }
    it { should_not be_valid }
  end
end
