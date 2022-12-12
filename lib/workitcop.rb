# frozen_string_literal: true

require_relative "workitcop/inject"
require_relative "workitcop/version"

require_relative "rubocop/cop/workit/mixin/rspec_explicit_help"
require_relative "rubocop/cop/workit/mixin/rspec_inflected_help"
require_relative "rubocop/cop/workit/mixin/rspec_predicate_matcher_base"

require_relative "rubocop/cop/workit/action_args"
require_relative "rubocop/cop/workit/comittee_assert_schema_confirm"
require_relative "rubocop/cop/workit/noop_rescue"
require_relative "rubocop/cop/workit/restrict_on_send"
require_relative "rubocop/cop/workit/rspec_capybara_match_style"
require_relative "rubocop/cop/workit/rspec_capybara_predicate_matcher"
require_relative "rubocop/cop/workit/rspec_minitest_assertions"

module Workitcop
  PROJECT_ROOT = ::Pathname.new(__dir__).parent.expand_path.freeze
  CONFIG_DEFAULT = PROJECT_ROOT.join("config", "default.yml").freeze
  CONFIG = ::YAML.safe_load(CONFIG_DEFAULT.read).freeze
  private_constant(:CONFIG_DEFAULT, :PROJECT_ROOT)
end

Workitcop::Inject.defaults!
