class AddJobIdToInstances < ActiveRecord::Migration
  def change
    add_column :instances, :job_id, :integer
    add_index  :instances, :job_id
  end
end
