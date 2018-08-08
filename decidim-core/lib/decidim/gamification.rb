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
      BadgeStatus.new(user, find_badge(badge_name))
    end

    def self.increment_score(user, badge_name, amount = 1)
      BadgeScorer.new(user, find_badge(badge_name)).increment(amount)
    end

    def self.set_score(user, badge_name, score)
      BadgeScorer.new(user, find_badge(badge_name)).set(score)
    end

    def self.badge_registry
      @badge_registry ||= Decidim::Gamification::BadgeRegistry.new
    end

    def self.badges
      badge_registry.all
    end

    def self.find_badge(name)
      badge_registry.find(name)
    end

    def self.register_badge(name, &block)
      badge_registry.register(name, &block)
    end

    def self.reset_badges(users = User.all)
      badges.each do |badge|
        Rails.logger.info "Resetting #{badge.name}..."

        if badge.reset
          users.find_each do |user|
            set_score(user, badge.name, badge.reset.call(user))
          end
        else
          Rails.logger.info "Badge can't be reset since it doesn't have a reset method."
        end
      end
    end
  end
end
