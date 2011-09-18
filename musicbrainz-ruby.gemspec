# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'musicbrainz/version'

Gem::Specification.new do |s|
  s.name = %q{musicbrainz-ruby}
  s.version = MusicBrainz::VERSION

  s.authors = ['Robin Tweedie']
  s.date = %q{2011-02-02}
  s.email = %q{robin@songkick.com}
  s.summary = %q{Simple Ruby wrapper for MusicBrainz XML Web Service}
  s.description = %q{Simple Ruby wrapper for MusicBrainz XML Web Service}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency(%q<httparty>, ["~> 0.8.0"])
  s.add_runtime_dependency(%q<hashie>, ["~> 1.1.0"])
  s.add_development_dependency(%q<rspec>, [">= 2.4"])
  s.add_development_dependency(%q<fakeweb>, [">= 1.3"])
end
