class AddRunAtToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :run_at, :string
  end
end
