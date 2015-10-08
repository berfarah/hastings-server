class AddIndexesToLogs < ActiveRecord::Migration
  def change
    add_index :logs, :loggable_type
    add_index :logs, :loggable_id
  end
end
