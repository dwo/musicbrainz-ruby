require 'musicbrainz'
require 'hashie/mash'

class MusicBrainz::Client
  class ParseMash < HTTParty::Parser
    def parse
      parsed = MultiJson.parse(body)
      Hashie::Mash.new(parsed['metadata'])
    end
  end

  parser ParseMash
end

client = Musicbrainz::Client.new
client.artist(:query => 'Diplo')
# =>
