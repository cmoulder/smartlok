class CreateSettings < ActiveRecord::Migration[5.0]
  def change
    create_table :settings do |t|

      t.decimal :lat

      t.decimal :lon

      t.decimal :radius

      t.string :title


      t.timestamps

    end

  end
end
