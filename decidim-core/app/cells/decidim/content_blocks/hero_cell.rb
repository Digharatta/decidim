# frozen_string_literal: true

module Decidim
  module ContentBlocks
    class HeroCell < Decidim::ViewModel
      include Decidim::CtaButtonHelper
      include Decidim::SanitizeHelper

      delegate :current_organization, to: :controller

      def decidim_participatory_processes
        Decidim::ParticipatoryProcesses::Engine.routes.url_helpers
      end

      def translated_welcome_text
        translated_attribute(model.settings.welcome_text)
      end
    end
  end
end
