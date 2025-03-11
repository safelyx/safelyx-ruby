# Safelyx API

[![](https://github.com/safelyx/safelyx-ruby/workflows/Run%20Tests/badge.svg)](https://github.com/safelyx/safelyx-ruby/actions?workflow=Run+Tests) [![pypi](https://badge.fury.io/rb/safelyx.svg)](https://rubygems.org/gems/safelyx)

> Safelyx API client

Safelyx API client for Ruby. 

You can find the API documentation at https://safelyx.com/safe-api.

### Some things to note:

1. It's simply making an HTTP request to the Safelyx API.

2. It provides types for the results and for the parameters.

3. If the request to the API fails (HTTP error), it will throw an error, so you might want to `rescue` it.

## Usage

It has a method per API endpoint.

```bash
gem install safelyx
```

```ruby
require 'safelyx'

client = Safelyx::Client.new('your-key-code')

result = client.check_link('https://example.com')

puts result[:result] # Outputs a safety score between 0 (unsafe) and 10 (safe). -1 if there was an error, -2 if there are no checks remaining.
```

## Development

Requires `ruby`.

```bash
make install
make format
make test
make build
```

## Publishing

After committing and pushing with a new version in `safelyx.gemspec`, just run:

```bash
make publish
```
