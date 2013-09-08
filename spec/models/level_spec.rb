require 'spec_helper'

describe Level do
  
  let(:card)  { FactoryGirl.create(:card) }
  let(:level) { card.build_level(status: 0, user: card.cardset.user) }

  subject { level }

  it { should respond_to(:status) }
  it { should respond_to(:card_id) }
  it { should respond_to(:user_id) }
  it { should respond_to(:card) }
  it { should respond_to(:user) }
  its(:card) { should eq card }

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