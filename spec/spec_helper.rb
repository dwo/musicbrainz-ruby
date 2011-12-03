require 'rubygems'

gem 'fakeweb', '~> 1.3.0'
require 'fakeweb'

dir = File.expand_path(File.dirname(__FILE__))
require File.join(dir, '..', 'lib', 'musicbrainz')

FakeWeb.allow_net_connect = false

base = MusicBrainz::Client.base_uri
{:artist_search_diplo => base + '/artist/?query=Diplo',
 :artist_by_id_diplo  => base + '/artist/a56bd8f9-8ef8-4d63-89a4-794ed1360dd2'
}.each do |fixture, url|
  path = File.join(dir, 'fixtures', "#{fixture}.xml")
  body = File.read(path) if File.file?(path)
  content_type = 'text/xml; charset=utf-8'
  FakeWeb.register_uri(:get, url, :body => body, :content_type => content_type)
  FakeWeb.register_uri(:head, url, :content_type => content_type)
end

bad_request = 'http://musicbrainz.org/ws/2/artist/'
body = File.read(File.join dir, 'fixtures', "artist_bad_request.txt")
FakeWeb.register_uri(:get, bad_request, :body => body, :status => ['400', 'Bad Request'])
FakeWeb.register_uri(:head, bad_request, :status => ['400', 'Bad Request'])

rating_request = 'http://musicbrainz.org/ws/2/rating/?id=4bd31567-70a8-4007-9ac6-3c68c7fc3d45&entity=artist'
error_body = File.read(File.join dir, 'fixtures', "rating_auth_required.html")
rating_body = File.read(File.join dir, 'fixtures', "rating_by_id.xml")
FakeWeb.register_uri(:get, rating_request, [{:body => error_body, :status => ["401", "Authorization Required"]},
                                            {:body => rating_body, :content_type => 'text/xml; charset=utf-8'}])
FakeWeb.register_uri(:head, rating_request, [{:status => ["401", "Authorization Required"]},
                                             {:content_type => 'text/xml; charset=utf-8'}])
