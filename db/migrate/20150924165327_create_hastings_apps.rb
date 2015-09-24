class CreateHastingsApps < ActiveRecord::Migration
  def change
    create_table :hastings_apps do |t|
      t.string :name
      t.string :ip

      t.timestamps null: false
    end
  end
end
