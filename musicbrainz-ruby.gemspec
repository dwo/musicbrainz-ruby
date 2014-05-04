$:.push File.expand_path('../lib', __FILE__)
require 'musicbrainz/version'

Gem::Specification.new do |s|
  s.name = %q{musicbrainz-ruby}
  s.version = MusicBrainz::VERSION

  s.authors      = ['Robin Tweedie']
  s.date         = %q{2013-05-04}
  s.email        = %q{robin.tweedie@gmail.com}
  s.summary      = %q{Simple Ruby client for MusicBrainz XML Web Service}
  s.description  = %q{}
  s.license      = 'MIT'
  s.requirements = 'An account at musicbrainz.org'

  s.files         = %w[lib/musicbrainz.rb
                       lib/musicbrainz/client.rb
                       lib/musicbrainz/request.rb
                       lib/musicbrainz/version.rb]
  s.test_files    = Dir.glob('spec/**/*_spec.rb')
  s.require_paths = ['lib']
  spec.required_ruby_version = '>= 1.8.7', '<= 2.1.0'

  s.add_runtime_dependency('httparty', '~> 0.13.0')

  s.add_development_dependency('rspec',   '~> 2.14.0')
  s.add_development_dependency('fakeweb', '~> 1.3.0')
end
