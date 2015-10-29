class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :public_id
      t.integer :width
      t.integer :height
      t.string :format
      t.integer :bytes
      t.string :url
      t.string :secure_url
      t.integer :machine_id

      t.timestamps null: false
    end
  end
end
