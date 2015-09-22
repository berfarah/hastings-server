class ChangeIntervalFormatFromStringToInteger < ActiveRecord::Migration
  def change
    change_column :hastings_tasks, :interval, :string
  end
end
