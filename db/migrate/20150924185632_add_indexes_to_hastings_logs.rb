class AddIndexesToHastingsLogs < ActiveRecord::Migration
  def change
    add_index :hastings_logs, :loggable_type
    add_index :hastings_logs, :loggable_id
  end
end
