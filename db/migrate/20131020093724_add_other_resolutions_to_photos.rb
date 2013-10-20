class AddOtherResolutionsToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :lowres_url, :string
    add_column :photos, :thumbnail_url, :string
  end
end
