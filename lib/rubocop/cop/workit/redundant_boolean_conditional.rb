# frozen_string_literal: true

module RuboCop
  module Cop
    module Workit
      # Checks for redundant boolean conditions.
      #
      # @example
      #   # bad
      #   true if x == y
      #
      #   # good
      #   x == y
      #
      class RedundantBooleanConditional < Base
        extend AutoCorrector

        MSG = "This conditional expression can just be replaced by `%<replaced>s`."

        # @!method true_or_false?(node)
        def_node_matcher :true_or_false?, <<~RUBY
          ({:true :false})
        RUBY

        def on_if(node)
          return unless redundant?(node)

          add_offense(node, message: offense_message(node)) do |corrector|
            corrector.replace(node, replacement_condition(node))
          end
        end

        private

        def offense_message(node)
          replacement = replacement_condition(node)
          replaced = node.elsif? ? "\n#{replacement}" : replacement

          format(MSG, replaced: replaced)
        end

        def redundant?(node)
          return false if node.else? || node.elsif? || node.elsif_conditional? || node.ternary?

          node.if_branch.true_type? || node.if_branch.false_type?
        end

        def replacement_condition(node)
          condition = node.condition.source
          expression = invert_expression?(node) ? "!(#{condition})" : condition

          node.elsif? ? indented_else_node(expression, node) : expression
        end

        def invert_expression?(node)
          (!node.elsif_conditional? && (node.if? && node.if_branch.false_type?)) ||
            (node.unless? && node.if_branch.true_type?)
        end

        def indented_else_node(expression, node)
          "else\n#{indentation(node)}#{expression}"
        end
      end
    end
  end
end
