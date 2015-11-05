class AddUserFieldToAppsAndTasks < ActiveRecord::Migration
  def change
    add_column :apps, :user_id, :integer, index: true, foreign_key: true
    add_column :tasks, :user_id, :integer, index: true, foreign_key: true
  end
end
