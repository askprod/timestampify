class Apis::Spotify::Tracks < Apis::Spotify::Abstract

  BASE_PATH = "/tracks"

  def self.get(track_id)
    artist_id = "11dFghVXANMlKmJXsNCbNl"
    self.new("/#{track_id}").get
  end

end