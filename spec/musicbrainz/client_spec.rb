require 'spec_helper'

describe MusicBrainz::Client do
  let(:client){ MusicBrainz::Client.new }
  subject { client }

  it 'provides access to the core resources' do
    resources = [:artist, :label, :recording, :release, :release_group, :work]
    should respond_to(*resources).with(1).argument
  end

  it 'provides access to the non-core resources' do
    should respond_to(:rating, :tag, :collection).with(1).argument
  end

  it 'provides access to the unique identifier lookups' do
    should respond_to(:discid, :puid, :isrc, :iswc).with(1).argument
  end

  it 'specifies a User-Agent in the headers' do
    expected = /musicbrainz-ruby gem/
    subject.class.default_options[:headers]['User-Agent'].should =~ expected
  end

  context 'when a User-Agent is provided' do
    let(:user_agent) { 'Herp Derp v1.2.3' }
    let(:client)     { MusicBrainz::Client.new(:'User-Agent' => user_agent) }

    it 'specifies the provided User-Agent in the headers' do
      subject.class.default_options[:headers]['User-Agent'].should == user_agent
    end
  end

  context 'when making a bad request' do
    subject { client.artist } # request has no parameters

    it 'raises an error' do
      lambda {subject}.should raise_error(ArgumentError, /Must specify a least one parameter/)
    end
  end

  context 'when requesting resources requiring authentication' do
    let(:mbid) { '4bd31567-70a8-4007-9ac6-3c68c7fc3d45' }
    subject { client.rating(:id => mbid, :entity => 'artist') }

    context 'and the resource is requested without authentication' do
      it 'raises an error' do
        lambda {subject}.should raise_error(RuntimeError, /Authorization Required/)
      end
    end

    context 'and the resource is requested with authentication' do
      let(:client) do
        MusicBrainz::Client.new(:username => 'user', :password => 'password')
      end

      it 'returns the resource' do
        subject.user_rating.should == "5"
      end
    end
  end

  context 'when searching for a resource' do
    subject { client.artist(:query => 'Diplo') }

    it 'returns a list of resources' do
      subject.artist_list.artist.should be_kind_of(Array)
      subject.artist_list.artist.size.should == 11
    end
  end

  context 'when fetching a resource by MusicBrainz id' do
    subject { client.artist(:mbid => 'a56bd8f9-8ef8-4d63-89a4-794ed1360dd2') }

    it 'returns a single resource' do
      subject.artist.should be_kind_of(Hashie::Mash)
      subject.artist.name.should == 'Diplo'
    end
  end

end
