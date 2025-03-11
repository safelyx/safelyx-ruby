# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name        = 'safelyx'
  spec.version     = '0.1.0'
  spec.summary     = 'Safelyx API SDK'
  spec.description = 'Safelyx API SDK for Ruby'
  spec.authors     = ['Safelyx']
  spec.email       = 'help@safelyx.com'
  spec.files       = ['safelyx.rb']

  github_link = 'https://github.com/safelyx/safelyx-ruby'

  spec.homepage    = github_link
  spec.license     = 'ISC'
  spec.required_ruby_version = '>= 3.0.0'

  spec.metadata = {
    'bug_tracker_uri' => "#{github_link}/issues",
    'changelog_uri' => "#{github_link}/releases",
    'documentation_uri' => 'https://safelyx.com/safe-api',
    'homepage_uri' => spec.homepage,
    'source_code_uri' => github_link,
    'rubygems_mfa_required' => 'true'
  }
end
