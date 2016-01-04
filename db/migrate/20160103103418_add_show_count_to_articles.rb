class AddShowCountToArticles < ActiveRecord::Migration
  def change
   add_column :articles ,:show_count, :integer, :comment => '浏览次数'
  end
end
