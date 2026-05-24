# frozen_string_literal: true

class WorkController < ApplicationController
  include WorkImage

  before_action :set_current_user

  def index
    @themes = Theme.all
    @selected_theme_id = params[:theme_id] || session[:selected_theme_id]

    if @selected_theme_id
      @images = Image.by_theme(@selected_theme_id)
    else
      @images = Image.all
    end
  end

  private

  def set_current_user
    # Берём первого пользователя из базы для теста
    @current_user = User.first
  end

  # Добавляем helper_method, чтобы current_user был доступен в Haml
  helper_method :current_user

  def current_user
    @current_user
  end

  def choose_theme
    @themes = Theme.all.pluck(:name)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def display_theme
    theme_id = Theme.find_theme_id(params[:theme])
    data = show_image(theme_id, 0)
    session[:selected_theme_id] = theme_id
    image_data(params[:theme], data)
  end

end
