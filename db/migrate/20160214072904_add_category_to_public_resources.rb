class AddCategoryToPublicResources < ActiveRecord::Migration
  def change
    add_column :public_resources, :category, :integer
  end
end
