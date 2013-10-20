class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.string :tags

      t.timestamps
    end

    create_table :categories_photos, id: false do |t|
        t.integer :category_id
        t.integer :photo_id
    end
  end
end
