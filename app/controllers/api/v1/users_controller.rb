class Api::V1::UsersController < ApplicationController
  before_action :authenticate_with_api_key!
  before_action :set_user, only: [:show, :update, :destroy]

  api :GET, '/users'
  def index
    @users = User.all
    render jsonapi: @users
  end

  api :GET, '/users/:id'
  def show
    render jsonapi: @user
  end

  api :POST, '/users'
  def create
    @user = User.new(user_params)

    if @user.save
      render jsonapi: @user, location: [:api, @user]
    else
      render jsonapi_errors: @user.errors
    end
  end

  api :PUT, '/users/:id'
  def update
    @user = current_user
    if @user.update(user_params)
      render jsonapi: @user, location: [:api, @user]
    else
      render jsonapi_errors: @user.errors
    end
  end

  api :DELETE, '/users'
  def destroy
    if @user.destroy
      head 204
    end
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
