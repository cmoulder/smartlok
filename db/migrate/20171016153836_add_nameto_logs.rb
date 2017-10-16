class AddNametoLogs < ActiveRecord::Migration[5.0]
  def change
    add_column :logs, :name, :string
  end
end
