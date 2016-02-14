class PublicResource < ActiveRecord::Base
  Department = ['事业','自收自支','公益']
  ADMINTIVE = ['厅','副厅','正处','副处', '正科', '副科']
  has_many :attachments, :as => :attachmentable
  accepts_nested_attributes_for :attachments, :reject_if => lambda { |item| item[:file].blank? }, :allow_destroy => true

  def self.import_excel(file)
    require "spreadsheet"
    return "请上传xls文件" if file.blank?
    Spreadsheet.client_encoding = 'UTF-8'
    xls = Spreadsheet.open file.tempfile.path rescue "请上传xls文件" and return "请上传xls文件"
    sheet = xls.worksheet 0
    titles = sheet.first
    msg = ["总共: #{sheet.row_count-1}条记录."]
    sheet.each_with_index do |row, index|
      #return row[0].blank?
      area = row[0].to_s
      institution_name = row[1].to_s
      level = row[2].to_s
      genre = row[3].to_s
      url = row[4].to_s
      zc = row[5]
      js = row[6]
      gt = row[7]
      cq = row[8]
      other = row[9].to_s
      category = row[10]
      nature = row[11].to_s
      administrative = row[12].to_s
      pattern = row[13].to_s
      cities_share = row[14].to_s
      center = row[15].to_s
      center_notice = row[16].to_s
      remark = row[17].to_s
      PublicResource.create(area: area,institution_name: institution_name,level: level,category: category, genre: genre,url:url,zc: zc,gt: gt, js: js,cq:cq,other: other,nature: nature,administrative: administrative,pattern: pattern,cities_share: cities_share,center: center,center_notice: center_notice,remark: remark)
    end

  end

end
