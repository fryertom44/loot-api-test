require 'test_helper'

class TransfersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @transfer = transfers(:one)
    @user = login_user
  end

  test "should get index" do
    get api_user_transfers_url, as: :json
    assert_response :success
  end

  test "should create transfer" do
    assert_difference('Transfer.count') do
      post api_user_transfers_url(@user), params: { transfer: { account_number_from: @transfer.account_number_from, account_number_to: @transfer.account_number_to, amount_pennies: @transfer.amount_pennies, country_code_from: @transfer.country_code_from, country_code_to: @transfer.country_code_to, user_id: @transfer.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show transfer" do
    get api_user_transfer_url(@user, @transfer), as: :json
    assert_response :success
  end

  test "should update transfer" do
    patch api_user_transfer_url(@user, @transfer), params: { transfer: { account_number_from: @transfer.account_number_from, account_number_to: @transfer.account_number_to, amount_pennies: @transfer.amount_pennies, country_code_from: @transfer.country_code_from, country_code_to: @transfer.country_code_to, user_id: @transfer.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy transfer" do
    assert_difference('Transfer.count', -1) do
      delete api_user_transfer_url(@user, @transfer), as: :json
    end

    assert_response 204
  end
end
