# Rake::Gitversion

[![Gem Version](https://badge.fury.io/rb/rake-gitversion.svg)](https://badge.fury.io/rb/rake-gitversion)
[![Build Status](https://travis-ci.org/skladd/rake-gitversion.svg?branch=master)](https://travis-ci.org/skladd/rake-gitversion)

This gem adds a task 'set_version' to rake, which uses annotated tags and the
'git describe' command to get a version string and save it to a VERSION file.
The patch number of the version string is the number of commits since the last
version tag.
If the git tree is dirty, minor is increased and the version marked as
prerelease by adding '.dev'.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rake-gitversion'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rake-gitversion

## Usage

In your Rakefile:

```ruby
require 'rake/gitversion'
```

Add an annotated version tag: 

```git tag -a -m 'minor' v0.1```

Run ```rake set_version```.

Consider adding ```VERSION``` to your .gitignore file, but make sure to run
to ```rake set_version``` after checkout or distribute ```VERSION``` file
somehow.


In your version.rb, use:

```ruby
# Version of gem and module
VERSION = begin
  File.read('VERSION')
rescue
  '0.pre'
end.freeze
```

## Development

After checking out the repo, run `bundle install` to install dependencies.
Then, run `rake test` to run the tests.

To install this gem onto your local machine, run `bundle exec rake install`.
To release a new version, update the version number in `version.rb`, and then
run `bundle exec rake release`, which will create a git tag for the version,
push git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/skladd/rake-gitversion.


## License

The gem is available as open source under the terms of the
[MIT License](http://opensource.org/licenses/MIT).

