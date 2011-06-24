# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{musicbrainz-ruby}
  s.version = "0.4.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Robin Tweedie", "Gregory Eremin"]
  s.date = %q{2011-06-24}
  s.email = %q{robin@songkick.com}
  s.extra_rdoc_files = ["README.markdown"]
  s.files = ["README.markdown", "lib/musicbrainz.rb"]
  s.homepage = %q{https://github.com/dwo/musicbrainz-ruby}
  s.rdoc_options = ["--main", "README.markdown"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.4.2}
  s.summary = %q{Simple Ruby wrapper for MusicBrainz XML Web Service 2}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<httparty>, [">= 0.7.3"])
      s.add_runtime_dependency(%q<hashie>, ["~> 1.0"])
      s.add_development_dependency(%q<rspec>, [">= 2.4"])
      s.add_development_dependency(%q<fakeweb>, [">= 1.3"])
    else
      s.add_dependency(%q<httparty>, [">= 0.7.3"])
      s.add_dependency(%q<hashie>, ["~> 1.0"])
      s.add_dependency(%q<rspec>, [">= 2.4"])
      s.add_dependency(%q<fakeweb>, [">= 1.3"])
    end
  else
    s.add_dependency(%q<httparty>, [">= 0.7.3"])
    s.add_dependency(%q<hashie>, ["~> 1.0"])
    s.add_dependency(%q<rspec>, [">= 2.4"])
    s.add_dependency(%q<fakeweb>, [">= 1.3"])
  end
end
