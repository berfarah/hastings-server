class DeleteLoggingsAndMoveToLog < ActiveRecord::Migration
  def change
    add_column :logs, :loggable_type, :string
    add_column :logs, :loggable_id, :integer
  end
end
