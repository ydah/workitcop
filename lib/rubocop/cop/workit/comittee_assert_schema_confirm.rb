# frozen_string_literal: true

module RuboCop
  module Cop
    module Workit
      # Check for not pass expected response status code to check it against the corresponding schema explicitly.
      #
      # This cop is deprecated.
      #
      # @see https://www.rubydoc.info/gems/workitcop/RuboCop/Cop/Workit/CommitteeExpectedResponseStatusCode
      #
      class ComitteeAssertSchemaConfirm < CommitteeExpectedResponseStatusCode
      end
    end
  end
end
