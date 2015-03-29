require 'spec_helper'

describe MusicBrainz::Client do
  CONTENT_TYPE = 'text/xml; charset=utf-8'

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
    expect(subject.class.default_options[:headers]['User-Agent']).to eq(described_class::DEFAULT_USER_AGENT)
  end

  context 'when a User-Agent is provided' do
    let(:expected_user_agent) { 'MyMusicBrainzApp/1.2.3 ( http://example.org )' }
    subject { described_class.new(:user_agent => expected_user_agent) }

    it 'specifies the provided User-Agent in the headers' do
      expect(subject.class.default_options[:headers]['User-Agent']).to eq(expected_user_agent)
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
      expect {
        subject.artist
      }.to raise_error(described_class::Error, /Must specify a least one parameter/)
    end
  end

  context 'when requesting resources requiring authentication' do
    subject      { described_class.new(:user => user, :password => password) }
    let(:mbid)   { '4bd31567-70a8-4007-9ac6-3c68c7fc3d45' }
    let(:entity) { described_class::RESOURCE_ARTIST }
    let(:expected_rating) { '5' }

    context 'and the resource is requested with authentication' do
      let(:user) { 'user' }
      let(:password) { 'password' }

      before do
        rating_uri = described_class.base_uri + "/rating/?id=#{mbid}&entity=#{entity}"
        expected_body = "<metadata><user-rating>#{expected_rating}</user-rating></metadata>"

        FakeWeb.register_uri(:head, rating_uri, :content_type => CONTENT_TYPE)
        FakeWeb.register_uri(:get,  rating_uri, :body         => expected_body,
                                                :content_type => CONTENT_TYPE)
      end

      it 'returns the resource' do
        expect(subject.rating(:id => mbid, :entity => entity)['user_rating']).
          to eq(expected_rating)
      end
    end

    context 'and the resource is requested without authentication' do
      let(:user) { nil }
      let(:password) { nil }

      before do
        rating_uri = described_class.base_uri + "/rating/?id=#{mbid}&entity=#{entity}"
        FakeWeb.register_uri(:head, rating_uri, :status => ['401', 'Authorization Required'])
        FakeWeb.register_uri(:get,  rating_uri, :status => ['401', 'Authorization Required'])
      end

      it 'raises an error' do
        expect { subject.rating(:id => mbid, :entity => entity) }.
          to raise_error(described_class::Error, /Authorization Required/)
      end
    end
  end

  context 'when searching for an existing resource' do
    let(:query) { 'Diplo' }
    let(:uri)   { described_class.base_uri + "/artist/?query=#{query}" }
    let(:expected_body) do
      path = File.expand_path(File.join('spec', 'fixtures', 'artist_search_diplo.xml'))
      File.read(path)
    end

    before do
      FakeWeb.register_uri(:head, uri, :content_type => CONTENT_TYPE)
      FakeWeb.register_uri(:get,  uri, :content_type => CONTENT_TYPE,
                                       :body         => expected_body)
    end

    it 'returns a list of resources' do
      results = subject.artist(:query => query)
      expect(results['artist_list']['artist']).to be_kind_of(Array)
      expect(results['artist_list']['artist'].size).to eq(11)
    end
  end

  context 'when fetching a resource by MusicBrainz id' do
    let(:mbid) { 'a56bd8f9-8ef8-4d63-89a4-794ed1360dd2' }
    let(:uri)  { described_class.base_uri + "/artist/#{mbid}" }
    let(:expected_body) do
      path = File.expand_path(File.join('spec', 'fixtures', 'artist_by_id_diplo.xml'))
      File.read(path)
    end

    before do
      FakeWeb.register_uri(:head, uri, :content_type => CONTENT_TYPE)
      FakeWeb.register_uri(:get,  uri, :content_type => CONTENT_TYPE,
                                       :body         => expected_body)
    end

    it 'returns a single resource' do
      response = subject.artist(:mbid => mbid)
      expect(response['artist']['name']).to eq('Diplo')
    end
  end
end
