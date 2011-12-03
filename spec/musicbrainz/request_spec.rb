require 'spec_helper'

describe MusicBrainz::Request do
  let(:resource) { 'artist' }
  let(:params)   { Hash.new }
  subject        { MusicBrainz::Request.new(resource, params) }

end
