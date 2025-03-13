class Auth0TokenService
  AUTH0_CLIENT_ID = ENV['AUTH0_CLIENT_ID']
  AUTH0_CLIENT_SECRET = ENV['AUTH0_CLIENT_SECRET']
  AUTH0_DOMAIN = ENV['AUTH0_DOMAIN']
  AUTH0_AUDIENCE = ENV['AUTH0_AUDIENCE']
  CACHE_KEY = 'auth0_m2m_token'
  CACHE_EXPIRY_BUFFER = 10 # seconds before expiry to refresh

  def self.fetch_token
    cached_token = Rails.cache.read(CACHE_KEY)
    return cached_token if cached_token.present?
    
    request_new_token
  end

  private

  private_class_method def self.request_new_token
    response = Faraday.post("#{AUTH0_DOMAIN}oauth/token") do |request|
      request.headers['Content-Type'] = 'application/json'
      request.body = {
        grant_type: 'client_credentials',
        client_id: AUTH0_CLIENT_ID,
        client_secret: AUTH0_CLIENT_SECRET,
        audience: AUTH0_AUDIENCE
      }.to_json
    end

    raise Auth0AuthenticationError.new(:unable_to_verify) unless response.success?

    token_data = JSON.parse(response.body)
    expires_in = token_data['expires_in'].to_int - CACHE_EXPIRY_BUFFER
    Rails.cache.write(CACHE_KEY, token_data['access_token'], expires_in: expires_in.seconds)
    token_data['access_token']
  rescue Faraday::Error => e
    Rails.logger.error("Error fetching token: #{e.message}")
    nil
  end
end
