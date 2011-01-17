require 'spec_helper'

describe MusicBrainz::Client do
  let(:client){ MusicBrainz::Client.new }
  
  context 'when making a bad request' do
    subject { client.artist }

    it 'should raise a useful error' do
      lambda {subject}.should raise_error(ArgumentError, /Must specify a least one parameter/)
    end
  end
  
  context 'when searching for an artist' do
    subject { client.artist(nil, :query => 'Diplo') }
    
    it 'returns a list of artists' do
      subject.artist_list.artist.should be_kind_of(Array)
      subject.artist_list.artist.size.should == 11
    end
  end
  
  context 'when fetching an artist by id' do
    subject { client.artist('a56bd8f9-8ef8-4d63-89a4-794ed1360dd2') }

    it 'returns a single artist' do
      subject.artist.should be_kind_of(Hashie::Mash)
      subject.artist.name.should == 'Diplo'
    end
  end
end