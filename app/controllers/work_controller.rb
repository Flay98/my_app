class WorkController < ApplicationController
  include WorkImage

  before_action :require_sign_in

  def index
    @themes = Theme.all
    @selected_theme_id = params[:theme_id].presence || Theme.first&.id
    session[:selected_theme_id] = @selected_theme_id

    @images = Image.by_theme(@selected_theme_id).order(:id)

    @current_index = params[:index].to_i
    @current_index = 0 if @current_index.negative?
    @current_index = 0 if @current_index >= @images.length
  end

  def display_theme
    theme_id = Theme.find_theme_id(params[:theme])
    data = show_image(theme_id, 0)
    session[:selected_theme_id] = theme_id
    image_data(params[:theme], data)
  end
end