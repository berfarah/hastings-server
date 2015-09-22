class RenameSirverityToSeverityBecauseImAnIdiot < ActiveRecord::Migration
  def change
    rename_column :hastings_logs, :serverity, :severity
  end
end
