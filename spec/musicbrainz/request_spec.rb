require 'spec_helper'

describe MusicBrainz::Request do
  let(:resource) { 'artist' }
  let(:params)   { Hash.new }
  subject        { described_class.new(resource, params) }

end
