require 'rubygems'
require 'fakeweb'

if ENV['COVERAGE']
  require 'simplecov'

  SimpleCov.start do
    add_filter '/vendor/'
  end
end

RSpec.configure do |config|
  config.order = 'random'
end

FakeWeb.allow_net_connect = false

dir = File.expand_path(File.dirname(__FILE__))
require File.join(dir, '..', 'lib', 'musicbrainz')
