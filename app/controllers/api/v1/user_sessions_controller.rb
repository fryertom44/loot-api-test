class Api::V1::UserSessionsController < ApplicationController
  
  def create
    user_name = user_session_params[:username]
    user_password = user_session_params[:password]
    user = user_name.present? && User.find_by(username: user_name)

    if user.authenticate(user_password)
      user.generate_api_key!
      user.save
      render json: user, status: 200, location: [:api, user]
    else
      render json: { errors: "Invalid username or password" }, status: 422
    end
  end

  def destroy
    user = current_user
    user.generate_api_key!
    user.save
    head 204
  end

  private

  def user_session_params
    params.require(:user_session).permit(:username, :password)
  end
end