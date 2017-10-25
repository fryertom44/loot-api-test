require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

setup do
  @user = users(:one)
end

test "has api key" do
  assert_respond_to(@user, :api_key)
end

test "has unique api key" do
  assert_respond_to(@user, :api_key)
end
end
