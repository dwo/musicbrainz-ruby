require 'rubygems'
require 'httparty'
require 'hashie'

module MusicBrainz
  class Client
    include HTTParty
    include Hashie

    base_uri 'musicbrainz.org/ws/1'
    
    def request(path, options)
      Mash.new(self.class.get(path, options)).metadata
    end

    def artist(musicbrainz_id = nil, params = {})
      options = {:query => {:type => 'xml'}}
      options[:query].merge!(params)
      
      request("/artist/#{musicbrainz_id}", options)
    end
  end
end
