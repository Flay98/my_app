module Api
  class ApiController < ApplicationController
    include WorkImage

    def next_image
      render_image(:next)
    end

    def prev_image
      render_image(:prev)
    end

    private

    def render_image(direction)
      current_index = params[:index].to_i
      theme_id = params[:theme_id].to_i
      length = params[:length].to_i

      new_index =
        if direction == :next
          next_index(current_index, length)
        else
          prev_index(current_index, length)
        end

      data = show_image(theme_id, new_index)

      render json: {
        new_image_index: data[:index],
        name: data[:name],
        file: data[:file],
        image_url: view_context.asset_path("pictures/#{data[:file]}"),
        image_id: data[:image_id],
        user_valued: data[:user_valued],
        common_ave_value: data[:common_ave_value] || "Нет оценок",
        value: data[:value],
        status: "success",
        notice: "Successfully listed image"
      }
    end
  end
end