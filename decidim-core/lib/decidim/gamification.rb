# frozen_string_literal: true

module Decidim
  module Gamification
    autoload :Badge, "decidim/gamification/badge"
    autoload :BadgeRegistry, "decidim/gamification/badge_registry"
    autoload :BadgeStatus, "decidim/gamification/badge_status"
    autoload :BadgeScorer, "decidim/gamification/badge_scorer"
    autoload :BaseEvent, "decidim/gamification/base_event"
    autoload :BadgeEarnedEvent, "decidim/gamification/badge_earned_event"
    autoload :LevelUpEvent, "decidim/gamification/level_up_event"

    def self.status_for(user, badge_name)
      BadgeStatus.new(user, badge_name)
    end

    def self.increment_score(user, badge_name)
      BadgeScorer.new(user, badge_name).increment
    end

    def self.badge_registry
      @badge_registry ||= Decidim::Gamification::BadgeRegistry.new
    end

    def self.badges
      badge_registry.badges
    end

    def self.find_badge(name)
      badges[name.to_sym]
    end

    def self.register_badge(name, &block)
      badge_registry.register(name, &block)
    end
  end
end
