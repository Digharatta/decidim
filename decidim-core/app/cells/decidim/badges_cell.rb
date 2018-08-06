# frozen_string_literal: true

module Decidim
  class BadgesCell < Decidim::ViewModel
    include Decidim::ApplicationHelper
    include Decidim::Core::Engine.routes.url_helpers

    delegate :current_user, to: :controller

    def show
      render :show
    end

    def user
      model
    end
  end
end
