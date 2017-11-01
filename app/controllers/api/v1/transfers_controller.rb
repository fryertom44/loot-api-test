class Api::V1::TransfersController < ApplicationController
  before_action :authenticate_with_api_key!
  before_action :set_user, only: [:show, :create, :update, :destroy]
  before_action :set_transfer, only: [:show, :update, :destroy]
  

  def_param_group :transfer do
    param :transfer, Hash, :required => true, :action_aware => true do
      param :account_number_from, String, "Account Number From", :required => false
      param :account_number_to, String, "Account Number To", :required => false
      param :amount_pennies, :number, "Amount of pennies", :required => false
      param :country_code_from, String, "Country Code From", :required => false
      param :country_code_to, String, "Country Code To", :required => false
      param :user_id, :number, "User ID", :required => false
    end
  end

  api :GET, '/users/:user_id/transfers/:id'
  def show
    render jsonapi: @transfer
  end

  api :POST, '/users/:user_id/transfers'
  param_group :transfer
  def create
    @transfer = @user.transfers.build(transfer_params)
    if @transfer.save
      render jsonapi: @transfer, location: [:api, @user, @transfer]
    else
      render jsonapi_errors: @transfer.errors
    end
  end

  api :PUT, '/users/:user_id/transfers'
  param_group :transfer
  def update
    if @transfer.update(transfer_params)
      render jsonapi: @transfer, location: [:api, @user, @transfer]
    else
      render jsonapi_errors: @transfer.errors
    end
  end

  api :DELETE, '/users/:user_id/transfers/:id'
  def destroy
    if @transfer.destroy
      head 204
    end
  end

  private

  def set_transfer
    @transfer = @user.transfers.find params[:id]
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def transfer_params
    params.require(:transfer)
          .permit(
            :account_number_from,
            :account_number_to,
            :amount_pennies,
            :country_code_from,
            :country_code_to,
            :user_id
            )
  end
end
