class AddZcToPublicResources < ActiveRecord::Migration
  def change
    add_column :public_resources, :zc, :string, comment: '政采'
    add_column :public_resources, :gt, :string, comment: '国土'
    add_column :public_resources, :js, :string, comment: '建设'
    add_column :public_resources, :cq, :string, comment: '产权'
    add_column :public_resources, :other, :text, comment: '其他'
    add_column :public_resources, :nature, :string, comment: '单位性质'
    add_column :public_resources, :administrative, :string, comment: '行政级别'
    add_column :public_resources, :pattern, :string, comment: '模式'
    add_column :public_resources, :cities_share, :string, comment: '地市共享'
    add_column :public_resources, :center, :string, comment: '政务中心'
    add_column :public_resources, :center_notice, :string, comment: '政采公告'
    add_column :public_resources, :remark, :text, comment: '备注'



  end
end
