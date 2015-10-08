class RemoveIpAndExternalFromTasks < ActiveRecord::Migration
  def change
    remove_column :tasks, :external
    remove_column :tasks, :ip
  end
end
