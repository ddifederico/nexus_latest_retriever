# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nexus_latest_retriever/version'

Gem::Specification.new do |spec|
  spec.name          = "nexus_latest_retriever"
  spec.version       = NexusLatestRetriever::VERSION
  spec.authors       = ["Daniele Di Federico"]
  spec.email         = ["daniele.difederico@gmail.com"]

  spec.summary       = %q{Retrieves the latest artifact from Nexus 3.}
  spec.description   = %q{Gem to retrieve the latest artefact from Nexus >3. It works with releases and snapshots.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
end
