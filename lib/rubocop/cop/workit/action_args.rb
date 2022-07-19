# frozen_string_literal: true

module RuboCop
  module Cop
    module Workit
      # Check for controller action must be using `action_args`.
      #
      # @example
      #   # bad
      #   class FooController
      #     def index
      #       # ...
      #     end
      #   end
      #
      #   # good
      #   class FooController
      #     def index(foo:)
      #       # ...
      #     end
      #
      #     def not_action
      #       # ...
      #     end
      #   end
      #
      class ActionArgs < Base
        MSG = "Consider using `action_args`."

        def on_def(node)
          add_offense(node) if !node.arguments? && controller_methods.include?(node.method_name.to_s)
        end

        private

        def controller_methods
          cop_config.fetch("ControllerMethods", [])
        end
      end
    end
  end
end
