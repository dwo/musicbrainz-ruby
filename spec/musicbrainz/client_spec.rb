require 'spec_helper'

describe MusicBrainz::Client do
  let(:client){ MusicBrainz::Client.new }
  
  context 'when searching for an artist' do
    subject { client.artist(nil, :query => 'Diplo') }
    
    it 'returns a list of artists' do
      subject.metadata.artist_list.artist.should be_kind_of(Array)
      subject.metadata.artist_list.artist.size.should == 11
    end
  end
  
  context 'when fetching an artist by id' do
    subject { client.artist('a56bd8f9-8ef8-4d63-89a4-794ed1360dd2') }
    
    it 'returns a single artist' do
      subject.metadata.artist.should be_kind_of(Hashie::Mash)
      subject.metadata.artist.name.should == 'Diplo'
    end
  end
end