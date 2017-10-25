class User < ApplicationRecord
  
  has_secure_password

  has_many :transfers

  validates :api_key, uniqueness: true

  before_create :set_initial_api_key

  def generate_api_key!
    self.api_key = generate_api_key
  end

  private

  def set_initial_api_key
    self.api_key ||= generate_api_key
  end

  def generate_api_key
    SecureRandom.uuid
  end

end
