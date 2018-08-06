# frozen_string_literal: true

module Decidim
  module Badges
    class Badge
      attr_reader :name
      attr_writer :levels

      def initialize(name)
        @name = name
      end

      def levels
        @levels || []
      end

      def level_count
        levels.length
      end

      def image
        ActionController::Base.helpers.asset_path("decidim/badges/#{name}.svg")
      end
    end
  end
end
