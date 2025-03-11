.PHONY: install
install:
	bundle install

.PHONY: format
format:
	bundle exec rubocop -A

.PHONY: test
test:
	bundle exec rubocop
	bundle exec rspec *_spec.rb

.PHONY: build
build:
	gem build safelyx.gemspec

.PHONY: publish
publish:
	gem build safelyx.gemspec
	gem push safelyx-0.*.gem
	rm safelyx-0.*.gem
