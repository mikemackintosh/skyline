# Created by hand, like a real man
# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'skyline/version'

Gem::Specification.new do |s|

  s.name        = 'skyline'
  s.version     = Skyline::VERSION
  s.date        = '2015-02-14'
  s.summary     = "A log analyzer"
  s.description = "A log analyzer"
  s.authors     = ["Mike Mackintosh"]
  s.email       = 'm@zyp.io'
  s.homepage    =
    'http://github.com/mikemackintosh/skyline'

  s.license       = 'MIT'
  
  s.require_paths = ["lib"]
  s.files         = `git ls-files -z`.split("\x0")
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})

  s.add_dependency 'httparty'
  s.add_dependency 'fattr'
  s.add_dependency 'paint'
  s.add_dependency 'methadone'

  s.add_development_dependency "bundler"
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"

end