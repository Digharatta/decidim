# frozen_string_literal: true

module Decidim
  module Gamification
    class BadgeRegistry
      attr_reader :badges

      def initialize
        @badges = {}
      end

      def register(name, &block)
        @badges[name.to_sym] = Badge.new(name).tap do |badge|
          badge.instance_eval(&block)
        end
      end
    end
  end
end
