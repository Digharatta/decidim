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
        t "decidim.badges.#{badge.name}.description_own", score: status.score
      else
        t "decidim.badges.#{badge.name}.description_another", score: status.score
      end
    end

    def next_level_in
      t "decidim.badges.#{badge.name}.next_level_in", score: status.next_level_in if status.next_level_in
    end

    private

    def status
      Decidim::Badges.status_for(user, badge.name)
    end
  end
end
