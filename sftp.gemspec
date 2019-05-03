# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "ws-sftp/version"

Gem::Specification.new do |gem|
  gem.name = %q{ws-sftp}
  gem.version = Ws::SFTP::VERSION
  gem.author = "Wealthsimple"
  gem.summary = %q{Ruby client for accessing SFTP}
  gem.email = %q{engineering@wealthsimple.com}
  gem.description   = %q{}
  gem.summary       = %q{}
  gem.homepage      = %q{}
  gem.files         = `git ls-files`.split("\n")
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.metadata['allowed_push_host'] = "https://nexus.iad.w10external.com/repository/gems-private"

  gem.add_dependency "net-sftp", "~> 2.0"

  gem.add_development_dependency "ws-gem_publisher", "~> 3"
end
