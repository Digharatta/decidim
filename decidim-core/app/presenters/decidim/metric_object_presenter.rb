# frozen_string_literal: true

module Decidim
  #
  # Decorator for users
  #
  class MetricObjectPresenter < SimpleDelegator
    def attr_string(attr, default: "")
      return default unless __getobj__
      __getobj__[attr].presence || default
    end

    def attr_date(attr, default: "")
      return default unless __getobj__
      __getobj__[attr].try(:strftime, "%Y-%m-%d") || default
    end

    def attr_translated(attr, locale: I18n.locale, default: "")
      return default unless __getobj__
      __getobj__[attr].try(:[], locale.to_s).presence || default
    end
  end
end
