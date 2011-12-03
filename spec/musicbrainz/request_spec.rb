require 'spec_helper'

describe MusicBrainz::Request do
  let(:resource) { 'artist' }
  let(:params)   { Hash.new }
  subject        { MusicBrainz::Request.new(resource, params) }

  it 'should put a default User-Agent in the header' do
    subject.options[:headers]['User-Agent'].should =~ /musicbrainz-ruby gem/
  end

end
