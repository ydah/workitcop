# frozen_string_literal: true

require "lint_roller"

module RuboCop
  module Workitcop
    # A plugin that integrates Workitcop with RuboCop's plugin system.
    class Plugin < LintRoller::Plugin
      def about
        LintRoller::About.new(
          name: "workitcop",
          version: Version::STRING,
          homepage: "https://github.com/ydah/workitcop",
          description: "A custom collection of working toolkits."
        )
      end

      def supported?(context)
        context.engine == :rubocop
      end

      def rules(_context)
        project_root = Pathname.new(__dir__).join("../..")

        LintRoller::Rules.new(type: :path, config_format: :rubocop, value: project_root.join("config", "default.yml"))
      end
    end
  end
end
