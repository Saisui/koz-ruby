# frozen_string_literal: true

require_relative "lib/koz/version"

Gem::Specification.new do |spec|
  spec.name = "puella"
  spec.version = Puella::VERSION
  spec.authors = ["彩穂"]
  spec.email = ["37037844+Saisui@users.noreply.github.com"]

  spec.summary = "The Comfortable Bot Framework."
  spec.description = "A bot framework support many protocol and api."
  spec.homepage = "https://github.com/saisui/koz-ruby"
  spec.required_ruby_version = ">= 3.2.0"
  spec.metadata["allowed_push_host"] = "https://rubygems.org"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://rubygems.org"
  spec.metadata["changelog_uri"] = "https://github.com/saisui/koz-ruby/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ Gemfile .gitignore .rspec spec/ .github/])
    end
  end
  # spec.bindir = "exe"
  # spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.bindir = "bin"
  spec.executables = ["kozbot.rb"]
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
