class Apis::Spotify::Abstract

  attr_reader :url, :headers, :payload

  BASE_URL      = "https://api.spotify.com/v1".freeze
  BASE_PATH     = "".freeze # Used in children classes
  CLIENT_ID     = Rails.application.credentials.spotify[:client_id].freeze
  CLIENT_SECRET = Rails.application.credentials.spotify[:client_secret].freeze
  CLIENT_ACCESS = nil_chain { Configuration.first.spotify_access_token }.freeze
  BASE_HEADERS  = { "Authorization" => "Bearer #{CLIENT_ACCESS}" }.freeze

  def initialize(url, headers: {}, payload: {})
    @url      = "#{self.class::BASE_URL}#{self.class::BASE_PATH}#{url}"
    @headers  = set_headers(headers)
    @payload  = payload
  end

  def self.get(url, headers: {}, payload: {})
    self.new(url, headers: headers, payload: payload).get
  end

  def self.post(url, headers: {}, payload: {})
    self.new(url, headers: headers, payload: payload).post
  end

  def get
    params  = { params: @payload.to_query }.merge!(@headers)
    request = RestClient.get(@url, params)
    JSON.parse(request)
  end

  def post
    request = RestClient.post(@url, @payload, @headers)
    JSON.parse(request)
  end

  private

  def set_headers(headers)
    return headers        if headers.is_a?(Hash) && headers.any?
    return BASE_HEADERS   if CLIENT_ACCESS.present?
    raise "Missing access token"
  end

end