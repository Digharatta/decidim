# frozen_string_literal: true

module Decidim
  module Conferences
    # The data store for a Registration in the Decidim::Conferences component.
    class Registration < ApplicationRecord
      include Decidim::DataPortability

      belongs_to :conference, foreign_key: "decidim_conference_id", class_name: "Decidim::Conferences::Conference"
      belongs_to :user, foreign_key: "decidim_user_id", class_name: "Decidim::User"

      validates :user, uniqueness: { scope: :conference }

      def self.user_collection(user)
        where(decidim_user_id: user.id)
      end

      def self.export_serializer
        Decidim::Conferences::DataPortabilityRegistrationSerializer
      end
    end
  end
end
