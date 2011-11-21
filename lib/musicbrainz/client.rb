require 'httparty'
require 'hashie'

module MusicBrainz
  class Client
    include HTTParty
    include Hashie

    base_uri 'musicbrainz.org/ws/2'

    DEFAULT_OPTIONS    = {:username => nil, :password => nil}

    # Provide your username and password to make authenticated calls
    def initialize(options = {})
      options.merge!(DEFAULT_OPTIONS)
      self.class.digest_auth options[:username], options[:password]
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

    def discid(params = {})
      request('discid', params)
    end

    def puid(params = {})
      request('puid', params)
    end

    def isrc(params = {})
      request('isrc', params)
    end

    def iswc(params = {})
      request('iswc', params)
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
      request = Request.new(resource, params)
      response = self.class.get(request.path, request.options)

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
