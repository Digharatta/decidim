# frozen_string_literal: true

module Decidim
  module Proposals
    ProposalMetricObjectInterface = GraphQL::InterfaceType.define do
      name "ProposalMetricObjectInterface"
      description "ProposalMetric object definition"

      field :published_at, !types.String, "Published at date" do
        resolve ->(obj, _args, _ctx) { MetricObjectPresenter.new(obj).attr_date(:published_at) }
      end

      field :state, !types.String, "current state" do
        resolve ->(obj, _args, _ctx) { MetricObjectPresenter.new(obj).attr_string(:state, default: "published") }
      end

      field :category, !types.String, "category" do
        resolve ->(obj, _args, _ctx) { MetricObjectPresenter.new(obj.category).attr_translated(:name) }
      end

      resolve_type ->(obj, _ctx) { obj.manifest.query_type.constantize }
    end
  end
end
