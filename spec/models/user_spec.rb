require 'rails_helper'

RSpec.describe User, type: :model do

  it { is_expected.to respond_to :api_key }
  # it { is_expected.to validate_uniqueness_of :api_key }

  describe "#generate_api_key!" do

    before(:each) do
      @user = FactoryBot.create(:user)
    end

    it "generates a unique token" do
      SecureRandom.stub(:uuid).and_return("auniquetoken123")
      @user.generate_api_key!
      expect(@user.api_key).to eql "auniquetoken123"
    end

    it "generates another token when one already has been taken" do
      existing_user = FactoryBot.create(:user)
      api_key = existing_user.api_key
      @user.generate_api_key!
      expect(@user.api_key).not_to eql existing_user.api_key
    end
  end
end
