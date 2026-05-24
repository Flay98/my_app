module Api
  class ApiController < ApplicationController
    include WorkImage

    # Переход к следующему изображению
    def next_image
      current_index = params[:index].to_i
      theme_id = params[:theme_id].to_i
      length = params[:length].to_i

      new_index = next_index(current_index, length)
      data = show_image(theme_id, new_index)

      render json: {
        new_image_index: data[:index],
        name: data[:name],
        file: data[:file],
        image_id: data[:image_id],
        user_valued: data[:user_valued],
        common_ave_value: data[:common_ave_value],
        value: data[:value],
        status: :success,
        notice: 'Successfully listed to next'
      }
    end

    # Переход к предыдущему изображению
    def prev_image
      current_index = params[:index].to_i
      theme_id = params[:theme_id].to_i
      length = params[:length].to_i

      new_index = prev_index(current_index, length)
      data = show_image(theme_id, new_index)

      render json: {
        new_image_index: data[:index],
        name: data[:name],
        file: data[:file],
        image_id: data[:image_id],
        user_valued: data[:user_valued],
        common_ave_value: data[:common_ave_value],
        value: data[:value],
        status: :success,
        notice: 'Successfully listed to previous'
      }
    end
  end
end