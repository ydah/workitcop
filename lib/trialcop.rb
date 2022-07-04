# frozen_string_literal: true

require_relative "trialcop/inject"
require_relative "trialcop/version"

module Trialcop
  PROJECT_ROOT = ::Pathname.new(__dir__).parent.expand_path.freeze
  CONFIG_DEFAULT = PROJECT_ROOT.join("config", "default.yml").freeze
  CONFIG = ::YAML.safe_load(CONFIG_DEFAULT.read).freeze
  private_constant(:CONFIG_DEFAULT, :PROJECT_ROOT)
end

Trialcop::Inject.defaults!
