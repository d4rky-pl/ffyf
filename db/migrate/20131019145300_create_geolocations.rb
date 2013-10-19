class CreateGeolocations < ActiveRecord::Migration
  def change
    create_table :geolocations do |t|
      t.integer :user_id
      t.string :name
      t.decimal :lat
      t.decimal :lng

      t.timestamps
    end
  end
end
