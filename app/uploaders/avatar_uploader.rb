class AvatarUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  process :convert => 'png'
  process :tags => [@mounted_as.to_s]

  # Generate a 164x164 JPG of 80% quality
  version :simple do
    process :resize_to_fill => [164, 164, :fill]
    process :convert => 'jpg'
    cloudinary_transformation :radius => "max", :width => 300, :height => 300, :crop => :imagga_crop
  end

  # Generate a 100x150 face-detection based thumbnail,
  # round corners with a 20-pixel radius and increase brightness by 30%.
  version :rounded do
    cloudinary_transformation :radius => "max", :width => 300, :height => 300, :crop => :imagga_crop
  end
end
