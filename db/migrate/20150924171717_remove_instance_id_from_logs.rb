class RemoveInstanceIdFromLogs < ActiveRecord::Migration
  def change
    remove_index :logs, :instance_id
    remove_column :logs, :instance_id
  end
end
