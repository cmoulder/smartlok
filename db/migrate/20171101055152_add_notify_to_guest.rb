class AddNotifyToGuest < ActiveRecord::Migration[5.0]
  def change
    add_column :guests, :notify, :boolean
  end
end
