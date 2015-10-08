class RenameSirverityToSeverityBecauseImAnIdiot < ActiveRecord::Migration
  def change
    rename_column :logs, :serverity, :severity
  end
end
