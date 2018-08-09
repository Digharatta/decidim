# frozen_string_literal: true

module Decidim
  module Admin
    # A form object used to configure a content block from the admin panel.
    #
    class ContentBlockForm < Decidim::Form
      include TranslatableAttributes

      mimic :content_block

      attribute :settings, Object

      def settings?
        settings.manifest.settings.any?
      end
    end
  end
end
