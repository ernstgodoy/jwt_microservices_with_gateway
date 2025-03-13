module TokenValidation
  extend ActiveSupport::Concern

  def authorize
    token = token_from_request
    @decoded_token = Auth0ValidationService.validate_token(token)
  rescue Auth0AuthenticationError => e
    raise e
  end

  # def validate_permissions(permissions)
#     raise 'validate_permissions needs to be called with a block' unless block_given?
#     return yield if @decoded_token.validate_permissions(permissions)

#     render json: INSUFFICIENT_PERMISSIONS, status: :forbidden
  # end

  private

  def token_from_request
    authorization_header = request.headers['Authorization']
    return raise Auth0AuthenticationError.new(:requires_authentication) unless authorization_header
    
    scheme, token = authorization_header.split(' ')
    return raise Auth0AuthenticationError.new(:bad_credentials) unless token && scheme.downcase == 'bearer'

    token
  end
end
