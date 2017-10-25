class Api::V1::TransfersController < ApplicationController
  before_action :authenticate_with_api_key!
  before_action :set_transfer, only: [:show, :update, :destroy]

  # GET /transfers/1
  def show
    render jsonapi: @transfer
  end

  # POST /transfers
  def create
    @transfer = Transfer.new(transfer_params)
    if @transfer.save
      render jsonapi: @transfer, location: [:api, @transfer]
    else
      render jsonapi_errors: @transfer.errors
    end
  end

  # PATCH/PUT /transfers/1
  def update
    if @transfer.update(transfer_params)
      render jsonapi: @transfer, location: [:api, @transfer]
    else
      render jsonapi_errors: @transfer.errors
    end
  end

  # DELETE /transfers/1
  def destroy
    if @transfer.destroy
      head 204
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transfer
      @transfer = Transfer.find(transfer_params[:id])
    end

    # Only allow a trusted parameter "white list" through.
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
