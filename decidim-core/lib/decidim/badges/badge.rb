# frozen_string_literal: true

module Decidim
  module Badges
    class Badge
      attr_reader :name, :levels

      def initialize(name)
        @name = name
      end

      def levels
        @levels || []
      end
    end
  end
end
