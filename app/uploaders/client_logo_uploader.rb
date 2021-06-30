require "image_processing/mini_magick"

class ClientLogoUploader < Shrine
  plugin :default_url
  plugin :derivatives
 
  Attacher.default_url do |**options|
    Rails.root.join("app/frontend/images/default_images/client-logo-missing.svg")
  end

  Attacher.derivatives do |original|
    magick = ImageProcessing::MiniMagick.source(original)

    { thumbnail: magick.resize_to_limit!(100, 100) }
  end
end