# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "ws-sftp/version"

Gem::Specification.new do |s|
  raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.' unless s.respond_to?(:metadata)

  s.name = %q{ws-sftp}
  s.version = Ws::SFTP::VERSION
  s.author = "Wealthsimple"
  s.summary = %q{Ruby client for accessing SFTP}
  s.email = %q{engineering@wealthsimple.com}
  s.description   = %q{}
  s.summary       = %q{}
  s.homepage      = %q{}
  s.files         = `git ls-files`.split("\n")
  s.executables   = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.metadata['allowed_push_host'] = "https://nexus.iad.w10external.com/repository/gems-private"

  s.add_dependency "net-sftp", ">= 4.0.0"

  s.required_ruby_version = '>= 3.0'

  s.add_development_dependency 'bundler-audit', '>= 0.9.0'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rspec-its'
  s.add_development_dependency 'ws-style'
end
