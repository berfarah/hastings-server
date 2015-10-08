class CreateInstances < ActiveRecord::Migration
  def change
    create_table :instances do |t|
      t.datetime :finished_at
      t.boolean :failed, default: false
      t.belongs_to :task, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
