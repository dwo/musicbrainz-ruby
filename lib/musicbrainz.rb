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

    UNIQUE_IDENTIFIERS = %q{discid puid isrc iswc}

    # Provide your username and password if you need to make authenticated calls
    def initialize(username = nil, password = nil)
      self.class.digest_auth username, password
    end

    def artist(params = {})
      request('artist', params)
    end

    def label(params = {})
      request('label', params)
    end

    def recording(params = {})
      request('recording', params)
    end

    def release_group(params = {})
      request('release-group', params)
    end

    def work(params = {})
      request('work', params)
    end

    def release(params = {})
      request('release', params)
    end

    def recording(params = {})
      request('recording', params)
    end

    def rating(params = {})
      request('rating', params)
    end

    def tag(params = {})
      request('tag', params)
    end

    def collection(params = {})
      request('collection', params)
    end

    def discid

    end

    def puid

    end

    def isrc

    end

    def iswc

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
    def request(resource, params)
      id, options = nil, {}

      if UNIQUE_IDENTIFIERS.include?(resource)
        id = params.delete(resource.to_sym)
      else
        id = params.delete(:mbid)
      end

      path = "/#{resource}/#{id}"
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
