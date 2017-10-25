module Concerns::Authenticable
  
  extend ActiveSupport::Concern
  
  def current_user
    @current_user ||= User.find_by(api_key: request.headers['X-Api-Key'])
  end

  def user_signed_in?
    current_user.present?
  end
  
  def authenticate_with_api_key!
    render json: { errors: "Not authenticated" },
    status: :unauthorized unless user_signed_in?
  end


end
