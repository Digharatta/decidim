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

        badge = Badge.new(name: name).tap do |object|
          object.instance_eval(&block)
        end

        badge.validate!

        @badges[name] = badge
      end

      def unregister(name)
        @badges.delete(name.to_s)
      end
    end
  end
end
