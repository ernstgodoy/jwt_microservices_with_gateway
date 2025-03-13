class Auth0ValidationService
  AUTH0_DOMAIN = ENV['AUTH0_DOMAIN']
  AUTH0_AUDIENCE = ENV['AUTH0_AUDIENCE']

  Token = Struct.new(:token) do
    def validate_permissions(permissions)
      required_permissions = Set.new permissions
      scopes = token[0]['scope']
      token_permissions = scopes.present? ? Set.new(scopes.split(" ")) : Set.new
      required_permissions <= token_permissions
    end
  end

  def self.validate_token(token)
    jwks_response = get_jwks
    jwks_hash = JSON.parse(jwks_response.body).deep_symbolize_keys

    Token.new(decode_token(token, jwks_hash))
  rescue JWT::VerificationError, JWT::DecodeError => e
    raise Auth0AuthenticationError.new(:bad_credentials)
  end

  private_class_method def self.decode_token(token, jwks_hash)
    JWT.decode(token, nil, true, {
                 algorithm: 'RS256',
                 iss: AUTH0_DOMAIN,
                 verify_iss: true,
                 aud: AUTH0_AUDIENCE,
                 verify_aud: true,
                 jwks: { keys: jwks_hash[:keys] }
               })
  end

  private_class_method def self.get_jwks
    response = Faraday.get("#{AUTH0_DOMAIN}.well-known/jwks.json")

    raise Auth0AuthenticationError.new(:unable_to_verify) unless response.success?

    response
  rescue Faraday::Error => e
    raise e
  end
end
