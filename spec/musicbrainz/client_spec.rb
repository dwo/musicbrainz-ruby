require 'spec_helper'

describe MusicBrainz::Client do
  let(:client){ MusicBrainz::Client.new }

  context 'when making a bad request' do
    subject { client.artist }

    it 'should raise a useful error' do
      lambda {subject}.should raise_error(ArgumentError, /Must specify a least one parameter/)
    end
  end
  
  context 'when requesting a resource requiring authentication' do
    subject { client.rating(:id => '4bd31567-70a8-4007-9ac6-3c68c7fc3d45', :entity => 'artist') }

    context 'a rating is requested without authentication' do
      it 'raises an error' do
        lambda {subject}.should raise_error(RuntimeError, /Authorization Required/)
      end
    end
    
    context 'a rating is requested with authentication' do
      let(:client) { MusicBrainz::Client.new('user', 'password') }
      
      it 'returns the rating' do
        subject.user_rating.should == "5"
      end
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
  
  context 'simple rating submission' do
    subject { client.post('rating', {:id => 'a56bd8f9-8ef8-4d63-89a4-794ed1360dd2', :entity => 'artist', :rating => 3}) }
    
    it 'should post successfully' do
      subject.should be_true
    end
  end
end