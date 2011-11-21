module MusicBrainz
  class Request

    UNIQUE_IDENTIFIERS = %q{discid puid isrc iswc}
    DEFAULT_USER_AGENT = "musicbrainz-ruby gem #{MusicBrainz::VERSION}"

    def initialize(resource, params)
      @resource   = resource
      @params     = params
      @id         = nil
      @user_agent = DEFAULT_USER_AGENT

      if UNIQUE_IDENTIFIERS.include?(resource)
        @id = params.delete(resource.to_sym)
      elsif params.has_key?(:mbid)
        @id = params.delete(:mbid)
      end
    end

    def path
      path = "/#{@resource}/#{@id}"
    end

    def options
      options = {}
      options[:query] = @params unless @params.empty?
      options[:headers] = {'User-Agent' => @user_agent}
      options
    end

  end
end
