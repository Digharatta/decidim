# frozen_string_literal: true

module Decidim
  module Gamification
    class BadgeScorer
      def initialize(user, badge_name)
        @user = user
        @badge_name = badge_name
      end

      def increment(amount = 1)
        with_level_tracking do
          BadgeScore.find_or_create_by(
            user: @user,
            badge_name: @badge_name
          ).increment(:value, amount).save!
        end
      end

      def set(score)
        with_level_tracking do
          BadgeScore.find_or_create_by(
            user: @user,
            badge_name: @badge_name
          ).update!(value: score)
        end
      end

      private

      def with_level_tracking
        previous_level = BadgeStatus.new(@user, @badge_name).level

        yield

        current_status = BadgeStatus.new(@user, @badge_name)
        send_notification(previous_level, current_status.level)
        current_status
      end

      def send_notification(previous_level, current_level)
        return unless current_level > previous_level

        if previous_level.zero?
          publish_event(name: "decidim.events.gamification.badge_earned",
                        klass: BadgeEarnedEvent,
                        previous_level: previous_level,
                        current_level: current_level)
        else
          publish_event(name: "decidim.events.gamification.level_up",
                        klass: LevelUpEvent,
                        previous_level: previous_level,
                        current_level: current_level)
        end
      end

      def publish_event(name:, klass:, previous_level:, current_level:)
        Decidim::EventsManager.publish(
          event: name,
          event_class: klass,
          resource: @user,
          recipient_ids: [@user.id],
          extra: {
            badge_name: @badge_name.to_s,
            previous_level: previous_level,
            current_level: current_level
          }
        )
      end
    end
  end
end
