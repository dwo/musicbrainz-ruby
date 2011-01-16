require 'rubygems'
require 'httparty'
require 'hashie'

module MusicBrainz
  class Client
    include HTTParty
    include Hashie
    
    base_uri 'musicbrainz.org/ws/1'

    def artist(musicbrainz_id = nil, params = {})
      options = {:query => {:type => 'xml'}}
      options[:query].merge!(params)
      
      Mash.new(self.class.get("/artist/#{musicbrainz_id}", options))
    end
  end
end
