# frozen_string_literal: true

module RuboCop
  module Cop
    module Workit
      # Check for not pass expected response status code to check it against the corresponding schema explicitly.
      #
      # @example
      #   # bad
      #   it 'something' do
      #     subject
      #     expect(response).to have_http_status 400
      #     do_something
      #     assert_schema_conform
      #   end
      #
      #   # good
      #   it 'something' do
      #     subject
      #     do_something
      #     assert_schema_conform(400)
      #   end
      #
      class ComitteeAssertSchemaConfirm < Base
        include RangeHelp
        extend AutoCorrector

        MSG = "Pass expected response status code to check it against the corresponding schema explicitly."
        RESTRICT_ON_SEND = %i[assert_schema_conform assert_response_schema_confirm].freeze

        # @!method have_http_status(node)
        def_node_search :have_http_status, <<~PATTERN
          $(send nil? :have_http_status (:int $_))
        PATTERN

        def on_send(node)
          return if node.arguments?

          have_http_status(node.parent) do |child_node, value|
            return autocorrect(node, child_node, value)
          end

          add_offense(node)
        end

        private

        def autocorrect(node, child_node, value)
          add_offense(node) do |corrector|
            corrector.remove(range_by_whole_lines(child_node.parent.loc.expression, include_final_newline: true))
            corrector.insert_after(node, "(#{value})")
          end
        end
      end
    end
  end
end
