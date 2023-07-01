# frozen_string_literal: true

require_relative "lib/migu/version"

Gem::Specification.new do |spec|
  spec.name = "migu"
  spec.version = Migu::VERSION
  spec.authors = ["Moeki Kawakami"]
  spec.email = ["me@moeki.dev"]

  spec.summary = "Ruby code base migration tool."
  spec.description = "Ruby code base migration tool."
  spec.homepage = "https://github.com/moekidev/migu"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/moekidev/migu"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "sqlite3", "~> 1.6"
  spec.add_dependency "dry-cli", "~> 1.0"
  spec.add_dependency "activesupport", ">= 4.2", "< 8.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
