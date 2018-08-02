# frozen_string_literal: true

module Decidim
  module ParticipatoryProcesses
    # This module's job is to extend the API with custom fields related to
    # decidim-proposals.
    module QueryExtensions
      # Public: Extends a type with `decidim-proposals`'s fields.
      #
      # type - A GraphQL::BaseType to extend.
      #
      # Returns nothing.
      def self.define(type)
        type.field :participatoryProcessesMetric, ParticipatoryProcesses::ParticipatoryProcessesMetricType, "Decidim's ParticipatoryProcessMetric data." do
          resolve ->(_obj, _args, ctx) { Decidim::ParticipatoryProcessesMetricResolver.new(ctx[:current_organization]) }
        end
      end
    end
  end
end
