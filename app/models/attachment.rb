class Attachment < ActiveRecord::Base
  belongs_to :attachmentable, polymorphic: true

  validate :file_size

  # 过滤没用的附件
  scope :file_present, -> { where("file is not NULL AND file <> ''") }

  mount_uploader :file, AttachmentUploader

  before_save :update_atts

  def update_atts
    if file.present? && file_changed?
      f_name = file.filename[file.filename.index("-")+1, file.filename.length]
      l_name = f_name[0, f_name.rindex("-")]
      self.file_name = l_name + ".#{file.extname}"
    end
  end

  def file_size
    errors.add(:file, "您上传的文件不能大于400M") if file.file && file.file.size.to_f/(1000) > 400000
  end

  def name
    if file.origin_name.include?('attachment-')
      url = file.origin_name
      return url[url.index("-")+1, url.length][0, url[url.index("-")+1, url.length].rindex("-")] + ".#{file.extname}" rescue file.origin_name
    end
    file.origin_name || self.file_name.presence
  end

  def icon
    case self.file.extname.downcase
    when "xls", "xlsx"
      "xls.png"
    when "png", "jpg", "jpeg", "bmp", "gif"
      "jpg.png"
    when "rar", "zip", "7z"
      "rar.png"
    when "doc", "docx"
      "doc.png"
    else
      "default.png"
    end
  end

  def increase_hit!
    self.hit = self.hit.to_i + 1
    save
  end
end
