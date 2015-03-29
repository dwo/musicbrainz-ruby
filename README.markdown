# MusicBrainz-ruby [![Build Status](https://travis-ci.org/dwo/musicbrainz-ruby.png?branch=master)](https://travis-ci.org/dwo/musicbrainz-ruby)

This project aims to be a simple [HTTParty][1] client to the [MusicBrainz XML
Web Service Version 2][2].

This gem currently only supports the lookup, browse and search GET requests.
Tested against Ruby 1.8.7 - 2.2.x.

[1]: https://github.com/jnunemaker/httparty
[2]: http://wiki.musicbrainz.org/XMLWebService

## Install

via [Bundler](http://bundler.io) in a Gemfile

    gem 'musicbrainz-ruby', :require => 'musicbrainz'

or via Rubygems on the command line

    gem install musicbrainz-ruby

## Examples

Be sure to read MusicBrainz's documentation on [Rate Limiting][3] to find out
how to make requests politely and set your User-Agent correctly.

```ruby
require 'musicbrainz'
brainz = MusicBrainz::Client.new(:user_agent => 'mbrexample-1.0.0', :username => 'username', :password => 'password')

# Find an artist by id (Janet Weiss), include artist relations
brainz.artist(:mbid => 'ede4e405-0715-4340-b612-ce79675d4133', :inc => 'artist-rels')

# Search for artists with the query 'Miriam Makeba'
brainz.artist(:query => 'Miriam Makeba')
```

If you want to parse the responses differently see HTTParty's [examples][4]
of custom parser procs. See also: the [example of musicbrainz-ruby v0-style
parsing][5].

[3]: https://musicbrainz.org/doc/XML_Web_Service/Rate_Limiting
[4]: http://github.com/jnunemaker/httparty/tree/master/examples/custom_parsers.rb
[5]: http://github.com/dwo/musicbrainz-ruby/tree/1_0_0/examples/custom_parser.rb

# MIT License

(c) Robin Tweedie 2011 - 2015

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
