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

  describe ".with_levels should return cards with levels of a certain user" do
    before { card.create_level(:status => 1, :user_id => 1, :sort_order => 1) }
  #  its(:with_levels_for(1)) { should be_an_instance_of() }
  end
end
