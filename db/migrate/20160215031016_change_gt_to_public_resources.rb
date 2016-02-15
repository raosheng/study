class ChangeGtToPublicResources < ActiveRecord::Migration
  def change
    change_column :public_resources,:zc,:boolean
    change_column :public_resources,:gt,:boolean
    change_column :public_resources,:js,:boolean
    change_column :public_resources,:cq,:boolean
  end
end
