require 'rubygems'
require 'fakeweb'

RSpec.configure do |config|
  config.order = 'random'
end

FakeWeb.allow_net_connect = false

dir = File.expand_path(File.dirname(__FILE__))
require File.join(dir, '..', 'lib', 'musicbrainz')
