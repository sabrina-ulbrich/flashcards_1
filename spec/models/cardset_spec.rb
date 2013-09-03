require 'spec_helper'

describe Cardset do
  let(:user) { FactoryGirl.create(:user) }
  before do
    @cardset = user.cardsets.build(topic: "Topic",
                description: "Description")
  end

  subject { @cardset }

  it { should respond_to(:topic) }
  it { should respond_to(:description) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }

  it { should be_valid }

  describe "when user_id is not present" do
  	before { @cardset.user_id = nil }
  	it { should_not be_valid }
  end

	describe "when topic is not present" do
		before { @cardset.topic = nil }
		it { should_not be_valid }
	end
end
