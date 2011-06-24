require 'rubygems'

gem 'httparty', '~> 0.7.3'
require 'httparty'

gem 'hashie', '~> 1.0'
require 'hashie'

module MusicBrainz
  class Client
    include HTTParty
    include Hashie

    base_uri 'musicbrainz.org/ws/2'
    @@useragent = nil
    
    # Provide your username and password if you need to make authenticated calls
    def initialize(username = nil, password = nil, useragent = nil)
      self.class.digest_auth username, password
      @@useragent = useragent
    end

    def artist(musicbrainz_id = nil, params = {})
      request("/artist/#{musicbrainz_id}", params)
    end
    
    def release_group(musicbrainz_id = nil, params = {})
      request("/release-group/#{musicbrainz_id}", params)
    end
    
    def release(musicbrainz_id = nil, params = {})
      request("/release/#{musicbrainz_id}", params)
    end
    
    def track(musicbrainz_id = nil, params = {})
      request("/track/#{musicbrainz_id}", params)
    end
    
    def label(musicbrainz_id = nil, params = {})
      request("/label/#{musicbrainz_id}", params)
    end
    
    def rating(params = {})
      request('/rating/', params)
    end
    
    def tag(params = {})
      request('/tag/', params)
    end
    
    def collection(params = {})
      request('/collection/', params)
    end
    
    # provide a resource you want to post to, and the appropriate parameters
    def post(resource, params = {})
      response = self.class.post("/#{resource}/", :body => params)
      if response.response.is_a? Net::HTTPOK
        return true
      else
        raise response.response.message
      end
    end
    
    private
    def request(path, params)
      options = {
        :query => params,
        :headers => @@useragent.nil? ? {} : {'User-Agent' => @@useragent}
      }
      
      response = self.class.get(path, options)
      
      if response.response.is_a? Net::HTTPBadRequest
        raise ArgumentError, response.parsed_response
      end
            
      if response.response.is_a? Net::HTTPUnauthorized
        raise response.response.message
      end
      
      Mash.new(response).metadata
    end
  end
end