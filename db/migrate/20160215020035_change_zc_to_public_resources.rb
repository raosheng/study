class ChangeZcToPublicResources < ActiveRecord::Migration
  def change
    change_column :public_resources,:zc,:integer
    change_column :public_resources,:gt,:integer
    change_column :public_resources,:js,:integer
    change_column :public_resources,:cq,:integer
  end
end
