# frozen_string_literal: true

require_relative "lib/workitcop/version"

Gem::Specification.new do |spec|
  spec.name = "workitcop"
  spec.version = Workitcop::VERSION
  spec.authors = ["ydah"]
  spec.email = ["t.yudai92@gmail.com"]

  spec.summary = "Custom cops for `RuboCop`."
  spec.homepage = "https://github.com/ydah/workitcop"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.require_paths = ["lib"]
  spec.files = Dir[
    "lib/**/*",
    "config/default.yml",
    "*.md"
  ]
  spec.extra_rdoc_files = ["LICENSE.txt", "README.md"]
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.add_runtime_dependency "rubocop", "~> 1.31"
end
