class AddTjToArticles < ActiveRecord::Migration
  def change
  	add_column :articles, :tj, :boolean, default: 0
  end
end
