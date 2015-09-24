class RemoveInstanceIdFromHastingsLogs < ActiveRecord::Migration
  def change
    remove_index :hastings_logs, :instance_id
    remove_column :hastings_logs, :instance_id
  end
end
