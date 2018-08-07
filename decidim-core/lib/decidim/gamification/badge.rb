# frozen_string_literal: true

module Decidim
  module Gamification
    class Badge
      include Virtus.model

      attribute :name, String
      attribute :levels, Array, default: []
      attribute :reset, Proc

      def level_count
        levels.length
      end

      def image
        ActionController::Base.helpers.asset_path("decidim/gamification/badges/#{name}.svg")
      end
    end
  end
end
