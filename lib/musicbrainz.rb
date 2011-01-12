require 'rubygems'
require 'httparty'

class MusicBrainz
  include HTTParty
  base_uri 'musicbrainz.org'

  def artist(musicbrainz_id, params = {})
    options = {}
    options[:query] = {:type => 'xml'}
    options[:query].merge!(params)
    
    self.class.get("/ws/1/artist/#{musicbrainz_id}", options)
  end
end
