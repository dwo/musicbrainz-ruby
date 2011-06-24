require "rubygems"
require "rake/gempackagetask"
require "rake/rdoctask"

task :default => :package do
  puts "Don't forget to write some tests!"
end

# This builds the actual gem. For details of what all these options
# mean, and other ones you can add, check the documentation here:
#
#   http://rubygems.org/read/chapter/20
#
spec = Gem::Specification.new do |s|

  # Change these as appropriate
  s.name              = "musicbrainz-ruby"
  s.version           = "0.4.0"
  s.summary           = "Simple Ruby wrapper for MusicBrainz XML Web Service 2"
  s.authors           = ["Robin Tweedie", "Gregory Eremin"]
  s.email             = "robin@songkick.com"
  s.homepage          = "https://github.com/dwo/musicbrainz-ruby"

  s.has_rdoc          = true
  s.extra_rdoc_files  = %w(README.markdown)
  s.rdoc_options      = %w(--main README.markdown)

  # Add any extra files to include in the gem
  s.files             = %w(README.markdown) + Dir.glob("{lib}/**/*")
  s.require_paths     = ["lib"]

  # If you want to depend on other gems, add them here, along with any
  # relevant versions
  s.add_dependency(%q<httparty>, [">= 0.7.3"])
  s.add_dependency(%q<hashie>, ["~> 1.0"])

  # If your tests use any gems, include them here
  s.add_development_dependency(%q<rspec>, [">= 2.4"])
  s.add_development_dependency(%q<fakeweb>, [">= 1.3"])
end

# This task actually builds the gem. We also regenerate a static
# .gemspec file, which is useful if something (i.e. GitHub) will
# be automatically building a gem for this project. If you're not
# using GitHub, edit as appropriate.
Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

desc "Build the gemspec file #{spec.name}.gemspec"
task :gemspec do
  file = File.dirname(__FILE__) + "/#{spec.name}.gemspec"
  File.open(file, "w") {|f| f << spec.to_ruby }
end

# If you don't want to generate the .gemspec file, just remove this line. Reasons
# why you might want to generate a gemspec:
#  - using bundler with a git source
#  - building the gem without rake (i.e. gem build blah.gemspec)
#  - maybe others?
task :package => :gemspec

# Generate documentation
Rake::RDocTask.new do |rd|
  rd.main = "README.markdown"
  rd.rdoc_files.include("README.markdown", "lib/**/*.rb")
  rd.rdoc_dir = "rdoc"
end

desc 'Clear out RDoc and generated packages'
task :clean => [:clobber_rdoc, :clobber_package] do
  rm "#{spec.name}.gemspec"
end
