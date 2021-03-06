# -*- encoding : utf-8 -*-

class AttachmentUploader < BaseUploader

  def store_dir
    dyniamc_dir
  end

  def url
    '/' + dyniamc_dir + "/#{file.try(:filename)}"
  end

  def origin_name
    url.split('-')[1] + ".#{extname}"
  end

  def extname
    file.filename.split('.')[1] rescue ''
  end

  def file_ext
    %w(doc txt zip rar pdf xls xlsx)
  end

  def image_ext
    %w(jpg jpeg gif png)
  end

  private
    def dyniamc_dir
      dir = image_ext.include?(extname) ? 'images' : 'files'
      "uploads/" + dir
    end
end
