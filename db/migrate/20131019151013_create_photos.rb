class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :place_id
      t.string :url, unique: true
      t.string :img_url
      t.string :username
      t.string :description

      t.timestamps
    end
  end
end
