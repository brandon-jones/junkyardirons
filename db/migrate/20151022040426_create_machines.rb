class CreateMachines < ActiveRecord::Migration
  def change
    create_table :machines do |t|
      t.string :title
      t.text :description
      t.integer :machine_set_id

      t.timestamps null: false
    end
  end
end
