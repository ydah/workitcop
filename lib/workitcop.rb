# frozen_string_literal: true

require "rubocop"
require "rubocop-rspec"

require_relative "workitcop/version"
require_relative "workitcop/plugin"

require_relative "rubocop/cop/workit/mixin/rspec_explicit_help"
require_relative "rubocop/cop/workit/mixin/rspec_inflected_help"
require_relative "rubocop/cop/workit/mixin/rspec_predicate_matcher_base"

require_relative "rubocop/cop/workit/action_args"
require_relative "rubocop/cop/workit/committee_expected_response_status_code"
require_relative "rubocop/cop/workit/noop_rescue"
require_relative "rubocop/cop/workit/redundant_boolean_conditional"
require_relative "rubocop/cop/workit/restrict_on_send"
require_relative "rubocop/cop/workit/rspec_capybara_match_style"
require_relative "rubocop/cop/workit/rspec_capybara_predicate_matcher"
require_relative "rubocop/cop/workit/rspec_minitest_assertions"
require_relative "rubocop/cop/workit/rspec_redundant_http_status"

# deprecated
require_relative "rubocop/cop/workit/comittee_assert_schema_confirm"
