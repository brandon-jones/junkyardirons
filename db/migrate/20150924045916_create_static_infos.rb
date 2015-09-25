class CreateStaticInfos < ActiveRecord::Migration
  def change
    create_table :static_infos do |t|
      t.string :key, unique: true
      t.text :value
      t.timestamps null: false
    end
  end
end