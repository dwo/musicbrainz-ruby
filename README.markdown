# MusicBrainz-ruby [![Build Status](https://travis-ci.org/dwo/musicbrainz-ruby.png?branch=master)](https://travis-ci.org/dwo/musicbrainz-ruby)

This aims to be the simplest possible [HTTParty][1] wrapper to the [MusicBrainz
XML Web Service Version 2][2].

This gem currently only supports the lookup, browse and search GET requests.

[1]: https://github.com/jnunemaker/httparty
[2]: http://wiki.musicbrainz.org/XMLWebService

## Install

    gem install musicbrainz-ruby

or in a Gemfile

    gem 'musicbrainz-ruby', :require => 'musicbrainz'

## Examples

    require 'musicbrainz'
    brainz = MusicBrainz::Client.new(:username => 'username',
                                     :password => 'password')

    # Find an artist by id, include artist relations
    brainz.artist(:mbid => '45d15468-2918-4da4-870b-d6b880504f77', :inc => 'artist-rels')
    # Search for artists with the query 'Diplo'
    brainz.artist(:query => 'Diplo')

# MIT License

(c) Robin Tweedie 2014

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
