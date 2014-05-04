require 'httparty'

module MusicBrainz
  class Client
    include HTTParty

    class Error < StandardError; end;

    base_uri 'musicbrainz.org/ws/2'

    def initialize(username = nil, password = nil)
      self.class.headers 'User-Agent' => "musicbrainz-ruby #{MusicBrainz::VERSION}"

      unless username.nil? and password.nil?
        self.class.digest_auth(username, password)
      end
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

    private
    def request(resource, params)
      request = Request.new(resource, params)
      response = self.class.get(request.path, request.options)

      if response.response.is_a?(Net::HTTPBadRequest)
        raise Error.new(response.parsed_response)
      end

      if response.response.is_a?(Net::HTTPUnauthorized)
        raise Error.new(response.message)
      end

      response.parsed_response['metadata']
    end
  end
end
