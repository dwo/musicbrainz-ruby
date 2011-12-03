require 'spec_helper'

describe MusicBrainz::Request do
  let(:resource) { 'artist' }
  let(:params)   { Hash.new }
  subject        { MusicBrainz::Request.new(resource, params) }

  it 'should put a default User-Agent in the headers' do
    subject.options[:headers]['User-Agent'].should =~ /musicbrainz-ruby gem/
  end

  context 'when a User-Agent is provided' do
    let(:user_agent) { 'Herp Derp v1.2.3' }
    let(:params)     { {:'User-Agent' => user_agent} }

    it 'should put the provided User-Agent in the headers' do
      subject.options[:headers]['User-Agent'].should == user_agent
    end
  end
end
