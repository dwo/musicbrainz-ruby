MusicBrainz-ruby
================

O hai, I [HTTParty][1]'d with ur [web service][2]. No offence, RBrainz gem.

This gem currently only supports the lookups. Data submission coming soon.

Returns [Mashes][3] of the metadata tag from MusicBrainz's XML responses.

[1]: https://github.com/jnunemaker/httparty
[2]: http://wiki.musicbrainz.org/XMLWebService
[3]: https://github.com/intridea/hashie

Install
-------

    gem install musicbrainz-ruby

Examples
--------

    require 'musicbrainz'
    brainz = MusicBrainz::Client.new('username', 'password')

    # Find an artist by id, include artist relations
    brainz.artist(:mbid => '45d15468-2918-4da4-870b-d6b880504f77', :inc => 'artist-rels')
    # Search for artists with the term 'Diplo'
    brainz.artist(:query => 'Diplo')

MIT License
===========

(c) Robin Tweedie 2011

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
