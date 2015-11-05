class CreateUpdates < ActiveRecord::Migration
  def change
    create_table :updates do |t|
      t.integer :updatable_id
      t.string :updatable_type
      t.belongs_to :user, index: true, foreign_key: true
      t.datetime :created_at
    end
  end
end
