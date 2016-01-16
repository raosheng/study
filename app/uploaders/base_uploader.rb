# -*- encoding : utf-8 -*-

class BaseUploader < CarrierWave::Uploader::Base

  storage :file
  CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/
  include CarrierWave::MimeTypes

  process :set_content_type

  def filename
    if super.present?
      @name ||= Digest::MD5.hexdigest(File.dirname(current_path))
      original_name = File.basename(original_filename).split('.')[0]
      "#{model_name}-#{original_name}-#{@name}#{File.extname(original_filename).downcase}"
    end
  end

  private
    def model_name
      model.class.to_s.underscore
    end
end
