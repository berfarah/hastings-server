class AddInstancesCountToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :instances_count, :integer, default: 0, null: false
  end
end
