class AddGidToLogs < ActiveRecord::Migration[5.0]
  def change
    add_column :logs, :gid, :integer
  end
end
