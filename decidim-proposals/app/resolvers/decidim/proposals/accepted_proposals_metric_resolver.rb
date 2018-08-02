# frozen_string_literal: true

module Decidim
  module Proposals
    # A GraphQL resolver to handle `count` and `metric` queries
    class AcceptedProposalsMetricResolver
      def initialize(organization)
        @organization = organization
        @metric_counter = Decidim::Proposals::Metrics::AcceptedProposalsMetricCount.for(@organization)
      end

      def metric
        @metric_counter.metric
      end

      def count
        @metric_counter.count
      end
    end
  end
end
