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
    
    # Provide your username and password if you need to make authenticated calls
    def initialize(username = nil, password = nil)
      self.class.digest_auth username, password
    end

    def artist(params = {})
      musicbrainz_id = params.delete(:mbid)
      request("/artist/#{musicbrainz_id}", params)
    end
    
    def release_group(params = {})
      musicbrainz_id = params.delete(:mbid)
      request("/release-group/#{musicbrainz_id}", params)
    end
    
    def release(params = {})
      musicbrainz_id = params.delete(:mbid)
      request("/release/#{musicbrainz_id}", params)
    end
    
    def track(params = {})
      musicbrainz_id = params.delete(:mbid)
      request("/track/#{musicbrainz_id}", params)
    end
    
    def label(params = {})
      musicbrainz_id = params.delete(:mbid)
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
      options = {}
      options[:query] = params
      
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
