class RemoveIpAndExternalFromHastingsTasks < ActiveRecord::Migration
  def change
    remove_column :hastings_tasks, :external
    remove_column :hastings_tasks, :ip
  end
end
