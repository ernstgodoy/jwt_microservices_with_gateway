module Service2Client
  SERVICE2_URL = ENV['SERVICE2_URL']

  def call_service2_endpoint(route)
    response = service2_connection.get(route)

    raise ServiceError.new(response.body[:error], response.status) unless response.success?

    response.body
  rescue Faraday::Error => e
    Rails.logger.error("Faraday error: #{e.message}")
    nil
  end

  private

  def service2_connection
    Faraday.new(url: SERVICE2_URL) do |connection|
      connection.request :authorization, 'Bearer', Auth0TokenService.fetch_token
      connection.request :json
      connection.response :json, parser_options: { symbolize_names: true }
      connection.adapter Faraday.default_adapter
    end 
  end
end