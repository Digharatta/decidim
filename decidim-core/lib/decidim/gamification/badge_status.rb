# frozen_string_literal: true

module Decidim
  module Gamification
    class BadgeStatus
      def initialize(user, badge_name)
        @user = user
        @badge = Decidim::Gamification.find_badge(badge_name)
      end

      def level
        level = 0

        return level unless score

        @badge.levels.each_with_index do |threshold, index|
          score >= threshold ? level = index + 1 : break
        end

        level
      end

      def next_level_in
        return nil if level >= @badge.levels.count
        @badge.levels[level] - score
      end

      def score
        @score ||= BadgeScore.find_by(user: @user, badge_name: @badge.name).try(:value)
      end
    end
  end
end
