# frozen_string_literal: true

module Decidim
  module Gamification
    class BadgeRegistry
      def initialize
        @badges = {}
      end

      def all
        @badges.values
      end

      def find(name)
        @badges[name.to_s]
      end

      def register(name, &block)
        name = name.to_s

        @badges[name] = Badge.new(name: name).tap do |badge|
          badge.instance_eval(&block)
        end
      end
    end
  end
end
