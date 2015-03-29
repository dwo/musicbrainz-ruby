$:.push File.expand_path('../lib', __FILE__)
require 'musicbrainz/version'

Gem::Specification.new do |s|
  s.name = %q{musicbrainz-ruby}
  s.version = MusicBrainz::VERSION

  s.authors      = ['Robin Tweedie']
  s.date         = '2015-03-29'
  s.email        = 'robin.tweedie@gmail.com'
  s.summary      = 'Simple Ruby client for MusicBrainz XML Web Service version 2.'
  s.description  = 'musicbrainz-ruby'
  s.license      = 'MIT'
  s.requirements = '(optional) An account at musicbrainz.org for requests requiring authentication'

  s.files         = Dir.glob('lib/**/*.rb')
  s.require_paths = ['lib']
  s.required_ruby_version = '>= 1.8.7', '< 2.3.0'

  s.add_runtime_dependency('httparty', '>= 0.7.3', '< 0.14')

  s.add_development_dependency('rspec',   '>= 2.11.0', '< 3.3')
  s.add_development_dependency('fakeweb', '~> 1.3.0')
end
