# frozen_string_literal: true

module Decidim
  module Gamification
    class BadgeStatus
      def initialize(user, badge)
        @user = user
        @badge = badge
      end

      def level
        @badge.level_of(score)
      end

      def next_level_in
        return nil if level >= @badge.levels.count
        @badge.levels[level] - score
      end

      def score
        @score ||= BadgeScore.find_by(user: @user, badge_name: @badge.name).try(:value) || 0
      end
    end
  end
end
