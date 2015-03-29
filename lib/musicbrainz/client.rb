require 'httparty'

module MusicBrainz
  class Client
    include HTTParty
    class Error < StandardError; end;

    base_uri 'musicbrainz.org/ws/2'

    DEFAULT_USER_AGENT = "musicbrainz-ruby/#{MusicBrainz::VERSION} ( #{MusicBrainz::GEM_HOMEPAGE} )".freeze
    USER_AGENT_REQUIRED = ':user_agent must be a non-blank string'.freeze

    # == Options
    #
    # * :+user_agent+: Specify a user agent for your client's requests. See: https://musicbrainz.org/doc/XML_Web_Service/Rate_Limiting#How_can_I_be_a_good_citizen_and_be_smart_about_using_the_Web_Service.3F
    # * :+username+: MusicBrainz.org username (optional, for requests requiring authentication)
    # * :+password+: MusicBrainz.org password (optional, for requests requiring authentication)
    def initialize(options = {})
      user_agent ||= options[:user_agent] || DEFAULT_USER_AGENT
      if user_agent.is_a?(String) && user_agent.length == 0
        raise ArgumentError.new(USER_AGENT_REQUIRED)
      end

      self.class.headers('User-Agent' => user_agent)

      unless options[:username].nil? || options[:password].nil?
        self.class.digest_auth(username, password)
      end
    end

    RESOURCE_ARTIST = 'artist'.freeze
    def artist(params = {})
      request(RESOURCE_ARTIST, params)
    end

    RESOURCE_LABEL = 'label'.freeze
    def label(params = {})
      request(RESOURCE_LABEL, params)
    end

    RESOURCE_RECORDING = 'recording'.freeze
    def recording(params = {})
      request(RESOURCE_RECORDING, params)
    end

    RESOURCE_RELEASE = 'release'.freeze
    def release(params = {})
      request(RESOURCE_RELEASE, params)
    end

    RESOURCE_RELEASE_GROUP = 'release-group'.freeze
    def release_group(params = {})
      request(RESOURCE_RELEASE_GROUP, params)
    end

    RESOURCE_WORK = 'work'.freeze
    def work(params = {})
      request(RESOURCE_WORK, params)
    end

    RESOURCE_RATING = 'rating'.freeze
    def rating(params = {})
      request(RESOURCE_RATING, params)
    end

    RESOURCE_TAG = 'tag'.freeze
    def tag(params = {})
      request(RESOURCE_TAG, params)
    end

    RESOURCE_COLLECTION = 'collection'.freeze
    def collection(params = {})
      request(RESOURCE_COLLECTION, params)
    end

    RESOURCE_DISC_ID = 'discid'.freeze
    def discid(params = {})
      request(RESOURCE_DISC_ID, params)
    end

    RESOURCE_PUID = 'puid'.freeze
    def puid(params = {})
      request(RESOURCE_PUID, params)
    end

    RESOURCE_ISRC = 'isrc'.freeze
    def isrc(params = {})
      request(RESOURCE_ISRC, params)
    end

    RESOURCE_ISWC = 'iswc'.freeze
    def iswc(params = {})
      request(RESOURCE_ISWC, params)
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
