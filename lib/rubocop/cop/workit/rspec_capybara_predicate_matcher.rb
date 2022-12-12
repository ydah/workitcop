# frozen_string_literal: true

module RuboCop
  module Cop
    module Workit
      # Prefer using predicate matcher over using predicate method directly.
      #
      # Capybara defines magic matchers for predicate methods.
      # This cop recommends to use the predicate matcher instead of using
      # predicate method directly.
      #
      # @example Strict: true, EnforcedStyle: inflected (default)
      #   # bad
      #   expect(foo.matches_css?(bar: 'baz')).to be_truthy
      #   expect(foo.matches_selector?(bar: 'baz')).to be_truthy
      #   expect(foo.matches_style?(bar: 'baz')).to be_truthy
      #   expect(foo.matches_xpath?(bar: 'baz')).to be_truthy
      #
      #   # good
      #   expect(foo).to match_css(bar: 'baz')
      #   expect(foo).to match_selector(bar: 'baz')
      #   expect(foo).to match_style(bar: 'baz')
      #   expect(foo).to match_xpath(bar: 'baz')
      #
      #   # also good - It checks "true" strictly.
      #   expect(foo.matches_style?(bar: 'baz')).to be(true)
      #
      # @example Strict: false, EnforcedStyle: inflected
      #   # bad
      #   expect(foo.matches_style?(bar: 'baz')).to be_truthy
      #   expect(foo.matches_style?(bar: 'baz')).to be(true)
      #
      #   # good
      #   expect(foo).to match_style(bar: 'baz')
      #
      # @example Strict: true, EnforcedStyle: explicit
      #   # bad
      #   expect(foo).to match_style(bar: 'baz')
      #
      #   # good - the above code is rewritten to it by this cop
      #   expect(foo.matches_style?(bar: 'baz')).to be(true)
      #
      # @example Strict: false, EnforcedStyle: explicit
      #   # bad
      #   expect(foo).to match_style(bar: 'baz')
      #
      #   # good - the above code is rewritten to it by this cop
      #   expect(foo.matches_style?(bar: 'baz')).to be_truthy
      #
      class RSpecCapybaraPredicateMatcher < Base
        extend AutoCorrector
        include RuboCop::Cop::Workit::RSpecPredicateMatcherBase

        MATCHER_SUFFIX = %w[css selector style xpath].freeze
        INFLECTED_MATCHER = MATCHER_SUFFIX.each.map do |suffix|
          "match_#{suffix}"
        end.freeze
        EXPLICIT_MATCHER = MATCHER_SUFFIX.each.map do |suffix|
          "matches_#{suffix}?"
        end.freeze

        def predicate_matcher_name?(name)
          name = name.to_s
          return false if allowed_explicit_matchers.include?(name)

          INFLECTED_MATCHER.include?(name)
        end

        def to_predicate_matcher(name)
          name.to_s.sub("matches_", "match_")[0..-2]
        end

        def predicate?(sym)
          EXPLICIT_MATCHER.include?(sym.to_s)
        end

        def to_predicate_method(matcher)
          "#{matcher.to_s.sub("match_", "matches_")}?"
        end
      end
    end
  end
end
