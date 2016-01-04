class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title, comment: '标题'
      t.text :content, content: '内容'
      t.string :author, comment: '作者'
      t.boolean :status, comment: '状态'

      t.timestamps 
    end
  end
end
