class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :name
      t.integer :id_instagram
      t.decimal :lat
      t.decimal :lng

      t.timestamps
    end
  end
end
