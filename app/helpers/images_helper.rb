module ImagesHelper
  def image_source_for(image)
    if image.photo.attached?
      url_for(image.photo)
    elsif image.file_name.present?
      asset_path("pictures/#{image.file_name}")
    end
  rescue Sprockets::Rails::Helper::AssetNotFound
    nil
  end
end