class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  include SessionsHelper

  before_action :set_locale

  private

  def set_locale
    I18n.locale = extract_locale || I18n.default_locale
    Rails.application.routes.default_url_options[:locale] = I18n.locale
  end

  def extract_locale
    locale = params[:locale]

    return nil if locale.blank?

    if I18n.available_locales.include?(locale.to_sym)
      locale
    else
      flash.now[:alert] = "#{locale} translation is not available"
      nil
    end
  end

  def default_url_options
    { locale: I18n.locale }
  end
end
