# frozen_string_literal: true

module RuboCop
  module Cop
    module Workit
      # Helper methods for Predicate matcher.
      module RSpecPredicateMatcherBase
        include ConfigurableEnforcedStyle
        include RSpecInflectedHelp
        include RSpecExplicitHelp

        RESTRICT_ON_SEND = %i[to to_not not_to].freeze

        def on_send(node)
          case style
          when :inflected
            check_inflected(node)
          when :explicit
            check_explicit(node)
          end
        end

        def on_block(node) # rubocop:disable InternalAffairs/NumblockHandler
          check_explicit(node) if style == :explicit
        end

        private

        # returns args location with whitespace
        # @example
        #   foo 1, 2
        #      ^^^^^
        def args_loc(send_node)
          send_node.loc.selector.end.with(
            end_pos: send_node.loc.expression.end_pos
          )
        end

        # returns block location with whitespace
        # @example
        #   foo { bar }
        #      ^^^^^^^^
        def block_loc(send_node)
          parent = send_node.parent
          return unless parent.block_type?

          send_node.loc.expression.end.with(
            end_pos: parent.loc.expression.end_pos
          )
        end
      end
    end
  end
end
