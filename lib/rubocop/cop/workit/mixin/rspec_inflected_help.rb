# frozen_string_literal: true

module RuboCop
  module Cop
    module Workit
      # A helper for `inflected` style
      module RSpecInflectedHelp
        include RuboCop::RSpec::Language
        extend NodePattern::Macros

        MSG_INFLECTED = "Prefer using `%<matcher_name>s` matcher over " \
                        "`%<predicate_name>s`."

        private

        def check_inflected(node)
          predicate_in_actual?(node) do |predicate, to, matcher|
            msg = message_inflected(predicate)
            add_offense(node, message: msg) do |corrector|
              remove_predicate(corrector, predicate)
              corrector.replace(node.loc.selector,
                                true?(to, matcher) ? "to" : "not_to")
              rewrite_matcher(corrector, predicate, matcher)
            end
          end
        end

        # @!method predicate_in_actual?(node)
        def_node_matcher :predicate_in_actual?, <<-PATTERN
          (send
            (send nil? :expect {
              (block $(send !nil? #predicate? ...) ...)
              $(send !nil? #predicate? ...)})
            $#Runners.all
            $#boolean_matcher?)
        PATTERN

        # @!method be_bool?(node)
        def_node_matcher :be_bool?, <<-PATTERN
          (send nil? {:be :eq :eql :equal} {true false})
        PATTERN

        # @!method be_boolthy?(node)
        def_node_matcher :be_boolthy?, <<-PATTERN
          (send nil? {:be_truthy :be_falsey :be_falsy :a_truthy_value :a_falsey_value :a_falsy_value})
        PATTERN

        def boolean_matcher?(node)
          if cop_config["Strict"]
            be_boolthy?(node)
          else
            be_bool?(node) || be_boolthy?(node)
          end
        end

        def predicate?(sym)
          raise ::NotImplementedError
        end

        def message_inflected(predicate)
          format(MSG_INFLECTED,
                 predicate_name: predicate.method_name,
                 matcher_name: to_predicate_matcher(predicate.method_name))
        end

        def to_predicate_matcher(name)
          raise ::NotImplementedError
        end

        def remove_predicate(corrector, predicate)
          range = predicate.loc.dot.with(
            end_pos: predicate.loc.expression.end_pos
          )

          corrector.remove(range)

          block_range = block_loc(predicate)
          corrector.remove(block_range) if block_range
        end

        def rewrite_matcher(corrector, predicate, matcher)
          args = args_loc(predicate).source
          block_loc = block_loc(predicate)
          block = block_loc ? block_loc.source : ""

          corrector.replace(
            matcher.loc.expression,
            to_predicate_matcher(predicate.method_name) + args + block
          )
        end

        def true?(to_symbol, matcher)
          result = case matcher.method_name
                   when :be, :eq
                     matcher.first_argument.true_type?
                   when :be_truthy, :a_truthy_value
                     true
                   when :be_falsey, :be_falsy, :a_falsey_value, :a_falsy_value
                     false
                   end
          to_symbol == :to ? result : !result
        end
      end
    end
  end
end
