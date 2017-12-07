class AddEmailToGuest < ActiveRecord::Migration[5.0]
  def change
    add_column :guests, :email, :string
  end
end
