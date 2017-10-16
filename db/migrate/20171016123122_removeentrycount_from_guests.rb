class RemoveentrycountFromGuests < ActiveRecord::Migration
  def up
    remove_column :Guests, :entrycount
  end
end
