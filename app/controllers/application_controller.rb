class ApplicationController < ActionController::API

  include Concerns::Authenticable
  include Concerns::Response
  
end
