require 'musicbrainz'
require 'hashie/mash'

class MusicBrainz::Client
  class ParseMash < HTTParty::Parser
    def parse
      parsed = MultiXml.parse(body)
      Hashie::Mash.new(parsed)
    end
  end

  parser ParseMash
end

client = MusicBrainz::Client.new
response = client.artist(:query => 'Diplo')

response.artist_list.artist.first.id
# => "a56bd8f9-8ef8-4d63-89a4-794ed1360dd2"
