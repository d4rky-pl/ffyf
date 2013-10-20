class AddLikesAndDislikesToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :likes, :integer, :default => 0
    add_column :places, :dislikes, :integer, :default => 0
  end
end
