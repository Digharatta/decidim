# frozen_string_literal: true

module Decidim
  module Meetings
    # This module's job is to extend the API with custom fields related to
    # decidim-proposals.
    module QueryExtensions
      # Public: Extends a type with `decidim-proposals`'s fields.
      #
      # type - A GraphQL::BaseType to extend.
      #
      # Returns nothing.
      def self.define(type)
        type.field :meetingsMetric, Meetings::MeetingsMetricType, "Decidim's MeetingMetric data." do
          resolve ->(_obj, _args, ctx) { Decidim::Meetings::MeetingsMetricResolver.new(ctx[:current_organization]) }
        end
      end
    end
  end
end
