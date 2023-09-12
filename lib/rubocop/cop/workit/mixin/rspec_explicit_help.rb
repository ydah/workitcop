# frozen_string_literal: true

module RuboCop
  module Cop
    module Workit
      # A helper for `explicit` style
      module RSpecExplicitHelp
        include RuboCop::RSpec::Language
        extend NodePattern::Macros

        MSG_EXPLICIT = "Prefer using `%<predicate_name>s` over " \
                       "`%<matcher_name>s` matcher."
        BUILT_IN_MATCHERS = %w[
          be_truthy be_falsey be_falsy
          have_attributes have_received
          be_between be_within
        ].freeze

        private

        def allowed_explicit_matchers
          cop_config.fetch("AllowedExplicitMatchers", []) + BUILT_IN_MATCHERS
        end

        def check_explicit(node)
          predicate_matcher_block?(node) do |actual, matcher|
            add_offense(node, message: message_explicit(matcher)) do |corrector|
              to_node = node.send_node
              corrector_explicit(corrector, to_node, actual, matcher, to_node)
            end
            ignore_node(node.children.first)
            return
          end

          return if part_of_ignored_node?(node)

          predicate_matcher?(node) do |actual, matcher|
            add_offense(node, message: message_explicit(matcher)) do |corrector|
              corrector_explicit(corrector, node, actual, matcher, matcher)
            end
          end
        end

        # @!method predicate_matcher?(node)
        def_node_matcher :predicate_matcher?, <<-PATTERN
          (send
            (send nil? :expect $!nil?)
            #Runners.all
            {$(send nil? #predicate_matcher_name? ...)
              (block $(send nil? #predicate_matcher_name? ...) ...)})
        PATTERN

        # @!method predicate_matcher_block?(node)
        def_node_matcher :predicate_matcher_block?, <<-PATTERN
          (block
            (send
              (send nil? :expect $!nil?)
              #Runners.all
              $(send nil? #predicate_matcher_name?))
            ...)
        PATTERN

        def predicate_matcher_name?(name)
          raise ::NotImplementedError
        end

        def message_explicit(matcher)
          format(MSG_EXPLICIT,
                 predicate_name: to_predicate_method(matcher.method_name),
                 matcher_name: matcher.method_name)
        end

        def corrector_explicit(corrector, to_node, actual, matcher, block_child)
          replacement_matcher = replacement_matcher(to_node)
          corrector.replace(matcher, replacement_matcher)
          move_predicate(corrector, actual, matcher, block_child)
          corrector.replace(to_node.loc.selector, "to")
        end

        def move_predicate(corrector, actual, matcher, block_child)
          predicate = to_predicate_method(matcher.method_name)
          args = args_loc(matcher).source
          block_loc = block_loc(block_child)
          block = block_loc ? block_loc.source : ""

          corrector.remove(block_loc) if block_loc
          corrector.insert_after(actual,
                                 ".#{predicate}" + args + block)
        end

        def to_predicate_method(matcher)
          raise ::NotImplementedError
        end

        def replacement_matcher(node)
          case [cop_config["Strict"], node.method?(:to)]
          when [true, true]
            "be(true)"
          when [true, false]
            "be(false)"
          when [false, true]
            "be_truthy"
          when [false, false]
            "be_falsey"
          end
        end
      end
    end
  end
end
