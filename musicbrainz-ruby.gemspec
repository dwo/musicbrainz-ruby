# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{musicbrainz-ruby}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Robin Tweedie"]
  s.date = %q{2011-01-12}
  s.email = %q{robin@songkick.com}
  s.extra_rdoc_files = ["README.markdown"]
  s.files = ["README.markdown", "lib/musicbrainz.rb"]
  s.homepage = %q{}
  s.rdoc_options = ["--main", "README.markdown"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{HTTParty wrapper for MusicBrainz XML Web Service}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
