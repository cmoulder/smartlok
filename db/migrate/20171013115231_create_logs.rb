class CreateLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :logs do |t|

      t.integer :accesscode

      t.string :status


      t.timestamps

    end

  end
end
