# frozen_string_literal: true

module Decidim
  class BadgeScore < ApplicationRecord
    belongs_to :user, class_name: "Decidim::User"
  end
end
