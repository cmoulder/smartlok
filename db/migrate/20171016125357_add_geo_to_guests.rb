class AddGeoToGuests < ActiveRecord::Migration[5.0]
  def change
    add_column :guests, :geo, :boolean
  end
end
