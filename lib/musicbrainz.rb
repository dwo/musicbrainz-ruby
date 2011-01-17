require 'rubygems'

gem 'httparty', '~> 0.6.1'
require 'httparty'

gem 'hashie', '~> 0.4.0'
require 'hashie'

module MusicBrainz
  class Client
    include HTTParty
    include Hashie

    base_uri 'musicbrainz.org/ws/1'
    
    def request(path, params)
      options = {:query => {:type => 'xml'}}
      options[:query].merge!(params)
      
      response = self.class.get(path, options)
      
      if response.response.is_a? Net::HTTPBadRequest
        raise ArgumentError, response.parsed_response
      end
      
      Mash.new(response).metadata
    end

    def artist(musicbrainz_id = nil, params = {})
      request("/artist/#{musicbrainz_id}", params)
    end
  end
end