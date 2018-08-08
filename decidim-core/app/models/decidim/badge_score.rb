# frozen_string_literal: true

module Decidim
  class BadgeScore < ApplicationRecord
    belongs_to :user, class_name: "Decidim::User"
    validates :user, presence: true
    validates :value, numericality: { greater_than_or_equal_to: 0 }
  end
end
