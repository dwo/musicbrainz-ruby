require 'spec_helper'

describe MusicBrainz::Client do
  subject      { described_class.new }
  after(:each) { FakeWeb.clean_registry }

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

  it 'specifies a default User-Agent in the headers' do
    expected = /musicbrainz-ruby gem/
    subject.class.default_options[:headers]['User-Agent'].should =~ expected
  end

  context 'when a User-Agent is provided' do
    subject          { described_class.new(:'User-Agent' => user_agent) }
    let(:user_agent) { 'Herp Derp v1.2.3' }

    it 'specifies the provided User-Agent in the headers' do
      subject.class.default_options[:headers]['User-Agent'].should == user_agent
    end
  end

  context 'when making a bad request (no parameters)' do
    before do
      bad_uri = described_class.base_uri + '/artist/'
      path = File.expand_path(File.join('spec', 'fixtures', 'artist_bad_request.txt'))
      body = File.read(path)
      FakeWeb.register_uri(:head, bad_uri, :status => ['400', 'Bad Request'])
      FakeWeb.register_uri(:get,  bad_uri, :status => ['400', 'Bad Request'],
                                           :body   => body)
    end

    it 'raises an error' do
      lambda { subject.artist }.
        should raise_error(ArgumentError, /Must specify a least one parameter/)
    end
  end

  context 'when requesting resources requiring authentication' do
    subject      { described_class.new(options) }
    let(:mbid)   { '4bd31567-70a8-4007-9ac6-3c68c7fc3d45' }
    let(:entity) { 'artist'}
    let(:expected_rating) { "5" }

    context 'and the resource is requested with authentication' do
      let(:options) { {:username => 'user', :password => 'password'} }
      before do
        rating_uri = described_class.base_uri + "/rating/?id=#{mbid}&entity=#{entity}"
        expected_body = "<metadata><user-rating>#{expected_rating}</user-rating></metadata>"

        FakeWeb.register_uri(:head, rating_uri, :content_type => 'text/xml; charset=utf-8')
        FakeWeb.register_uri(:get,  rating_uri, :body         => expected_body,
                                                :content_type => 'text/xml; charset=utf-8')
      end

      it 'returns the resource' do
        subject.rating(:id => mbid, :entity => entity).
                user_rating.
                should == expected_rating
      end
    end

    context 'and the resource is requested without authentication' do
      let(:options) { Hash.new }
      before do
        rating_uri = described_class.base_uri + "/rating/?id=#{mbid}&entity=#{entity}"
        FakeWeb.register_uri(:head, rating_uri, :status => ["401", "Authorization Required"])
        FakeWeb.register_uri(:get,  rating_uri, :status => ["401", "Authorization Required"])
      end

      it 'raises an error' do
        lambda { subject.rating(:id => mbid, :entity => entity) }.
          should raise_error(RuntimeError, /Authorization Required/)
      end
    end

  end

  context 'when searching for an existing resource' do
    let(:query) { 'Diplo' }

    before do
      uri = described_class.base_uri + "/artist/?query=#{query}"

      path = File.expand_path(File.join('spec', 'fixtures', 'artist_search_diplo.xml'))
      expected_body = File.read(path)
      content_type = 'text/xml; charset=utf-8'

      FakeWeb.register_uri(:head, uri, :content_type => content_type)
      FakeWeb.register_uri(:get,  uri, :content_type => content_type,
                                       :body         => expected_body)
    end

    it 'returns a list of resources' do
      results = subject.artist(:query => query).artist_list.artist
      results.should be_kind_of(Array)
      results.size.should == 11
    end
  end

  context 'when fetching a resource by MusicBrainz id' do
    let(:mbid) { 'a56bd8f9-8ef8-4d63-89a4-794ed1360dd2' }

    before do
      uri = described_class.base_uri + "/artist/#{mbid}"

      path = File.expand_path(File.join('spec', 'fixtures', 'artist_by_id_diplo.xml'))
      expected_body = File.read(path)
      content_type = 'text/xml; charset=utf-8'

      FakeWeb.register_uri(:head, uri, :content_type => content_type)
      FakeWeb.register_uri(:get,  uri, :content_type => content_type,
                                       :body         => expected_body)
    end

    it 'returns a single resource' do
      artist = subject.artist(:mbid => mbid).artist
      artist.should be_kind_of(Hashie::Mash)
      artist.name.should == 'Diplo'
    end
  end

end
