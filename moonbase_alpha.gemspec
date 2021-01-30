require_relative 'lib/moonbase_alpha/version'

Gem::Specification.new do |spec|
  spec.name          = "moonbase_alpha"
  spec.version       = MoonbaseAlpha::VERSION
  spec.authors       = ["Logan Bowers"]
  spec.email         = ["logan@datacurrent.com"]

  spec.summary       = %q{Builds an AWS Lambda-ready Docker image for a rails app}
  spec.description   = %q{Builds an AWS Lambda-ready Docker image for a rails app}
  spec.homepage      = "https://github.com/loganb/moonbase_alpha"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  # spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir['LICENSE.md', 'README.md', 'lib/**/*', 'templates/**/*']
  spec.test_files    = Dir['test/**/*.rb']
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
