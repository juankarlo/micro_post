require 'spec_helper'

describe Relationship do

  let(:follower) { FactoryGirl.create(:user) }
  let(:followed) { FactoryGirl.create(:user) }
  let(:relationship) { follower.relationships.build(followed_id: followed.id) }

  subject { relationship }

  it { should be_valid }

  describe "Follower methods" do
    it { should respond_to(:follower) }
    it { should respond_to(:followed) }
    its(:follower) { should eq follower }
    its(:followed) { should eq followed }
  end

  describe "When followed_id isn't present" do
    before { relationship.followed_id = nil }
    it { should_not be_valid }
  end

  describe "When follower_id isn't present" do
    before { relationship.follower_id = nil }
    it { should_not be_valid }
  end
end
