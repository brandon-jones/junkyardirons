class CreateInstagramTable < ActiveRecord::Migration
  def change
    create_table :instagrams do |t|
      t.string :image_tags
      t.datetime :created_time
      t.string :image_id, unique: true
      t.text :instagram_link
      t.text :low_resolution_url
      t.text :thumbnail_url
      t.text :standard_resolution_url
      t.text :caption
    end
  end
end