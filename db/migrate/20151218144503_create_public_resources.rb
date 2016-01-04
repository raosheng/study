class CreatePublicResources < ActiveRecord::Migration
  def change
    create_table :public_resources do |t|
      t.string :area, comment: '区域'
      t.string :institution_name, comment: '机构名称'
      t.string :level, comment: '级别'
      t.string :genre, comment: '类型'
      t.string :url, comment: '网址'

      t.timestamps
    end
  end
end
