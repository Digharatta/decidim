# frozen_string_literal: true

module Decidim
  module Gamification
    class Badge
      include Virtus.model
      include ActiveModel::Validations

      attribute :name, String
      attribute :levels, Array, default: []
      attribute :reset, Proc

      validates :name, :levels, presence: true
      validates :levels, empty: false

      validate do
        errors.add(:levels, "level thresholds should be ordered") if levels.sort != levels
        errors.add(:levels, "level thresholds should be positive") unless levels.all?(&:positive?)
        errors.add(:levels, "level thresholds should be unique") unless levels.uniq == levels
      end

      def level_of(score)
        levels.each_with_index do |threshold, index|
          return index if threshold > score
        end

        levels.length
      end

      def image
        ActionController::Base.helpers.asset_path("decidim/gamification/badges/#{name}.svg")
      end
    end
  end
end
