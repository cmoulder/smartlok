class AddExpireToGuest < ActiveRecord::Migration[5.0]
  def change
    add_column :guests, :expire, :date
  end
end
