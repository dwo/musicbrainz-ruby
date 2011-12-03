module MusicBrainz
  class Request

    UNIQUE_IDENTIFIERS = %q{discid puid isrc iswc}

    def initialize(resource, params)
      @resource   = resource
      @params     = params
      @id         = nil

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
      options
    end

  end
end
