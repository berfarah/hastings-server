class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.boolean :external, default: false
      t.string :ip
      t.string :script
      t.string :scalar
      t.string :interval
      t.boolean :enabled

      t.timestamps null: false
    end
  end
end
