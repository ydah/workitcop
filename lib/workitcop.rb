# frozen_string_literal: true

require_relative "workitcop/inject"
require_relative "workitcop/version"

require_relative "rubocop/cop/workit/action_args"
require_relative "rubocop/cop/workit/restrict_on_send"

module Workitcop
  PROJECT_ROOT = ::Pathname.new(__dir__).parent.expand_path.freeze
  CONFIG_DEFAULT = PROJECT_ROOT.join("config", "default.yml").freeze
  CONFIG = ::YAML.safe_load(CONFIG_DEFAULT.read).freeze
  private_constant(:CONFIG_DEFAULT, :PROJECT_ROOT)
end

Workitcop::Inject.defaults!
