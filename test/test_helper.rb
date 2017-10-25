require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def login user
    user.authenticate('testpassword')
  end

  def login_user
    user = users(:one)
    login user  
  end

end
