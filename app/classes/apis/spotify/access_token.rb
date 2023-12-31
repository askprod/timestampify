class Apis::Spotify::AccessToken < Apis::Spotify::Abstract

  BASE_URL = "https://accounts.spotify.com".freeze

  def self.update_config
    token = self.fetch.dig("access_token")
    Configuration.create unless Configuration.any?
    Configuration.last.update(spotify_access_token: token)
  end

  def self.fetch
    path          = "/api/token"
    payload       = { grant_type: "client_credentials" }
    headers       = {
      'Authorization' => "Basic #{Base64.strict_encode64("#{CLIENT_ID}:#{CLIENT_SECRET}")}",
      "Content-Type"  => "application/x-www-form-urlencoded"
    }

    self.new(path, headers: headers, payload: payload).post
  end

end