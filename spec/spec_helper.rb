require 'rubygems'

gem 'fakeweb', '~> 1.3.0'
require 'fakeweb'

dir = File.expand_path(File.dirname(__FILE__))
require File.join(dir, '..', 'lib', 'musicbrainz')

FakeWeb.allow_net_connect = false

{:artist_search_diplo => 'http://musicbrainz.org/ws/1/artist/?type=xml&query=Diplo',
 :artist_by_id_diplo  => 'http://musicbrainz.org/ws/1/artist/a56bd8f9-8ef8-4d63-89a4-794ed1360dd2?type=xml',
}.each do |fixture, url|
  body = File.read(File.join dir, 'fixtures', "#{fixture}.xml")
  FakeWeb.register_uri(:get, url, :body => body, :content_type => 'text/xml; charset=utf-8')
end