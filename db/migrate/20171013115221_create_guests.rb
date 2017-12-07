class CreateGuests < ActiveRecord::Migration[5.0]
  def change
    create_table :guests do |t|

      t.string :name

      t.integer :accesscode

      t.integer :allowedcount

      t.boolean :unrestricted


      t.timestamps

    end

  end
end
