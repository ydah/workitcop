# frozen_string_literal: true

require "rubocop"

require_relative "workitcop/version"
require_relative "workitcop/plugin"

require_relative "rubocop/cop/workit/action_args"
require_relative "rubocop/cop/workit/noop_rescue"
require_relative "rubocop/cop/workit/redundant_boolean_conditional"
require_relative "rubocop/cop/workit/restrict_on_send"
require_relative "rubocop/cop/workit/rspec_redundant_http_status"
