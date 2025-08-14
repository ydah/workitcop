# frozen_string_literal: true

require_relative "lib/workitcop/version"

Gem::Specification.new do |spec|
  spec.name = "workitcop"
  spec.version = Rubocop::Workitcop::Version::STRING
  spec.authors = ["ydah"]
  spec.email = ["t.yudai92@gmail.com"]

  spec.summary = "A custom cop collection of working toolkits."
  spec.homepage = "https://github.com/ydah/workitcop"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"
  spec.metadata["rubygems_mfa_required"] = "true"
  spec.metadata["default_lint_roller_plugin"] = "RuboCop::Workitcop::Plugin"

  spec.require_paths = ["lib"]
  spec.files = Dir[
    "lib/**/*",
    "config/default.yml",
    "*.md"
  ]
  spec.extra_rdoc_files = ["LICENSE.txt", "README.md"]
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.add_dependency "lint_roller", "~> 1.1"
  spec.add_dependency "rubocop", ">= 1.72.1", "< 2.0"
end
