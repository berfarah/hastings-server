class ChangeIntervalFormatFromStringToInteger < ActiveRecord::Migration
  def change
    change_column :tasks, :interval, :string
  end
end
