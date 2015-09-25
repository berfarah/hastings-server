class AddJobIdToHastingsInstances < ActiveRecord::Migration
  def change
    add_column :hastings_instances, :job_id, :integer
    add_index  :hastings_instances, :job_id
  end
end
