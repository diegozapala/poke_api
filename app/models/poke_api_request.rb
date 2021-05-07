class PokeApiRequest
  require "net/http"

  MAIN_API_URL = "https://pokeapi.co/api/v2/"

  attr_reader :api_url

  def self.get_url(context)
    "#{MAIN_API_URL}#{context}"

  end

  def initialize(api_url:)
    @api_url = api_url
  end

  def get_response
    @response ||= Net::HTTP.get_response(api_uri)
  end

  def response_ok?
   get_response.message == "OK"
  end

  def response_body
    @response_body ||= parse_to_json(get_response.body)
  end

  private

  def api_uri
    @uri ||= URI(api_url)
  end

  def parse_to_json(string)
    JSON.parse(string);
  end

end
