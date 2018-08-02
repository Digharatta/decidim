# frozen_string_literal: true

module Decidim
  module Assemblies
    # A GraphQL resolver to handle `count` and `metric` queries
    class AssembliesMetricResolver < Decidim::Core::MetricResolver
      def initialize(organization)
        super(organization)
        @metric_counter = Decidim::Assemblies::Metrics::AssembliesMetricCount.for(@organization)
      end
    end
  end
end
