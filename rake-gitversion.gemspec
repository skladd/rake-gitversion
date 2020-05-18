# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rake/gitversion/version'

Gem::Specification.new do |spec|
  spec.name          = 'rake-gitversion'
  spec.version       = Rake::Gitversion::VERSION
  spec.authors       = ['Stephan Klatt']
  spec.email         = ['stephan.klatt@gmail.com']

  spec.summary       = 'Get version from git and write it to file'
  spec.description   = 'Get version from git tags and commits since then and'
                       ' write it to VERSION file'
  spec.homepage      = 'https://github.com/skladd/rake-gitversion'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '>= 12.3.3'
  spec.add_development_dependency 'minitest', '~> 5.9'
  spec.add_development_dependency 'minitest-reporters', '~> 1.1'
  spec.add_development_dependency 'mocha', '~> 1.1'
end
