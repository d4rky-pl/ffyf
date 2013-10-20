class FixDescriptionFieldOfPhoto < ActiveRecord::Migration
  def change
    change_column :photos, :description, :text
  end
end
