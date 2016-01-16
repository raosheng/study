class AddPicUrlToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :pic_url, :string
  end
end
