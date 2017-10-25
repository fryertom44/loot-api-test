class Api::V1::UsersController < ApplicationController
  before_action :authenticate_with_api_key!, only: [:update, :destroy]
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    @users = User.all

    json_response @users
  end

  # GET /users/1
  def show
    json_response @user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      json_response @user, :created
    else
      json_response @user.errors, :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    @user = current_user
    if @user.update(user_params)
      json_response @user, 200
    else
      json_response @user.errors, 422
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = current_user
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:username, :first_name, :last_name, :address_line_1, :dob, :password, :password_confirmation, :api_key)
    end
end
