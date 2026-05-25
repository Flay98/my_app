# frozen_string_literal: true

module WorkImage
  extend ActiveSupport::Concern

  def show_image(theme_id, image_index)
    theme_images = Image.by_theme(theme_id)

    return empty_image_data(image_index) if theme_images.blank?

    image = theme_images[image_index]

    {
      index: image_index,
      values_qty: ExpertRating.count,
      current_user_id: current_user&.id,
      theme_id: theme_id,
      images_arr_size: theme_images.size,
      image_id: image.id,
      name: image.description,
      file: image.file_name,
      user_valued: false,
      value: nil,
      common_ave_value: image.average_rating_text
    }
  end

  def next_index(index, length)
    return 0 if length <= 0

    index < length - 1 ? index + 1 : 0
  end

  def prev_index(index, length)
    return 0 if length <= 0

    index > 0 ? index - 1 : length - 1
  end

  private

  def empty_image_data(image_index)
    {
      index: image_index,
      values_qty: 0,
      current_user_id: current_user&.id,
      theme_id: nil,
      images_arr_size: 0,
      image_id: nil,
      name: "",
      file: "",
      user_valued: false,
      value: nil,
      common_ave_value: "Нет оценок"
    }
  end
end
