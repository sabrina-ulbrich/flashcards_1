require 'spec_helper'

describe Card do
  
  let(:cardset) { FactoryGirl.create(:cardset) }

  before { @card = cardset.cards.build(question: "Question",
  																		answer: "Answer") }

  subject { @card }

  it { should respond_to(:question) }
  it { should respond_to(:answer) }
  it { should respond_to(:cardset_id) }
  it { should respond_to(:cardset) }
  its(:cardset) { should eq cardset }

  it { should be_valid }

  describe "when cardset_id is not present" do
  	before { @card.cardset_id = nil }
  	it { should_not be_valid }
  end
end
