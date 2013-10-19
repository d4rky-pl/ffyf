class FixPlacesTable < ActiveRecord::Migration
  def change
    drop_table :places

    create_table :places do |t|
      t.string :name
      t.integer :id_instagram
      t.decimal :lat, :precision => 15, :scale => 10
      t.decimal :long, :precision => 15, :scale => 10

      t.timestamps
    end
  end
end
