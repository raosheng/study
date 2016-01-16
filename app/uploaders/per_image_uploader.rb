# -*- encoding : utf-8 -*-

class PerImageUploader < CarrierWave::Uploader::Base

  CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/

  include CarrierWave::MimeTypes

  storage :file

  def store_dir
    date = model.created_at.nil? ? Date.today : model.created_at.to_date
    "uploads/#{model.class.to_s.underscore}/#{date}/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg gif png swf)
  end

end
