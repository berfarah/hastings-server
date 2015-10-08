class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.string :serverity
      t.string :message
      t.belongs_to :instance, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
