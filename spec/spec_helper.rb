require 'rubygems'

gem 'fakeweb', '~> 1.3.0'
require 'fakeweb'

dir = File.expand_path(File.dirname(__FILE__))
require File.join(dir, '..', 'lib', 'musicbrainz')

FakeWeb.allow_net_connect = false

{:artist_search_diplo => 'http://musicbrainz.org/ws/2/artist/?query=Diplo',
 :artist_by_id_diplo  => 'http://musicbrainz.org/ws/2/artist/a56bd8f9-8ef8-4d63-89a4-794ed1360dd2',
}.each do |fixture, url|
  body = File.read(File.join dir, 'fixtures', "#{fixture}.xml")
  FakeWeb.register_uri(:get, url, :body => body, :content_type => 'text/xml; charset=utf-8')
  FakeWeb.register_uri(:head, url, :content_type => 'text/xml; charset=utf-8')
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

rating_post = 'http://musicbrainz.org/ws/2/rating/'
success_response = File.read(File.join dir, 'fixtures', "successful_post.xml")
FakeWeb.register_uri(:post, rating_post, {:body => success_response, :content_type => 'text/xml; charset=utf-8'})
FakeWeb.register_uri(:head, rating_post, {:content_type => 'text/xml; charset=utf-8'})
