class AddRunAtToHastingsTasks < ActiveRecord::Migration
  def change
    add_column :hastings_tasks, :run_at, :string
  end
end
