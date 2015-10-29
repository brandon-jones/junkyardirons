class CreateMachineSets < ActiveRecord::Migration
  def change
    create_table :machine_sets do |t|
      t.string :title
      t.text :description
      t.decimal :price, :precision => 8, :scale => 2
      t.integer :quantity
      t.text :image_url

      t.timestamps null: false
    end
  end
end
