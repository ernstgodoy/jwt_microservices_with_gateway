class ApplicationController < ActionController::API
  include JwtValidation
  rescue_from Auth0AuthenticationError do |e|
    render json: { error: e.message }, status: e.status
  end
end
