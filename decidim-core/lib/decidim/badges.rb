# frozen_string_literal: true

module Decidim
  module Badges
    autoload :Badge, "decidim/badges/badge"
    autoload :BadgeRegistry, "decidim/badges/badge_registry"
    autoload :BadgeStatus, "decidim/badges/badge_status"

    def self.status_for(user, badge_name)
      BadgeStatus.new(user, badge_name)
    end

    def self.increment_score(user, badge_name)
      BadgeScore.find_or_create_by(
        user: user,
        badge_name: badge_name
      ).increment!(:value)
    end
  end
end
