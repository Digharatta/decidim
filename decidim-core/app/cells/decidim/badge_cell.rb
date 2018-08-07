# frozen_string_literal: true

module Decidim
  class BadgeCell < Decidim::ViewModel
    include Decidim::ApplicationHelper
    include Decidim::Core::Engine.routes.url_helpers
    include Decidim::IconHelper

    delegate :current_user, to: :controller, prefix: false

    def show
      render :show
    end

    def badge
      @options[:badge]
    end

    def user
      model
    end

    def description
      if user == current_user
        t "decidim.gamification.badges.#{badge.name}.description_own", score: status.score
      else
        t "decidim.gamification.badges.#{badge.name}.description_another", score: status.score
      end
    end

    def next_level_in
      t "decidim.gamification.badges.#{badge.name}.next_level_in", score: status.next_level_in if status.next_level_in
    end

    def badge_name
      t "decidim.gamification.badges.#{badge.name}.name"
    end

    private

    def status
      Decidim::Gamification.status_for(user, badge.name)
    end
  end
end
