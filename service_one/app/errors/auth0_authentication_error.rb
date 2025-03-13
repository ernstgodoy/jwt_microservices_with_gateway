class Auth0AuthenticationError < StandardError
  attr_reader :status

  ERROR_MESSAGES = {
    requires_authentication: 'Requires authentication',
    malformed_header: 'Malformed header' ,
    insufficient_permissions: 'Permission denied',
    bad_credentials: 'Bad credentials',
    unable_to_verify: 'Unable to verify credentials'
  }.freeze

  def initialize(error_type)
    super(ERROR_MESSAGES[error_type])
    @status = :unauthorized
  end
end
