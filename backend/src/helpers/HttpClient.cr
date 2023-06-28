require "http/client"
require "json"
require "./serializers/locationsOptimizedFormated"

class HttpClient

  @httpClient : HTTP::Client

  def initialize(@baseURL : String)
    @httpClient = HTTP::Client.new(@baseURL, tls: true)
  end

  def get(endpoint : String)
    response = @httpClient.get(endpoint)
    response.body
  end

  def post (endpoint : String, body)
    response = @httpClient.post(
      endpoint,
      headers: HTTP::Headers{"Content-Type" => "application/json"},
      body: body
    )

    response = JSON.parse(response.body)
    response["data"]["locationsByIds"].as_a.map do |location|
      LocationsOptimizedFormated.from_json(location.to_json)
    end
  end
end