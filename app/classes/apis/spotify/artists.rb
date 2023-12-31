class Apis::Spotify::Artists < Apis::Spotify::Abstract

  BASE_PATH = "/artists"

  def self.get(artist_id)
    artist_id = "4Z8W4fKeB5YxbusRsdQVPb"
    self.new("/#{artist_id}").get
  end

end