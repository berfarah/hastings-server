class DeleteLoggingsAndMoveToLog < ActiveRecord::Migration
  def change
    add_column :hastings_logs, :loggable_type, :string
    add_column :hastings_logs, :loggable_id, :integer
  end
end
