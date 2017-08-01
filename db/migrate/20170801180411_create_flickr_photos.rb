class CreateFlickrPhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :flickr_photos do |t|
      t.string :city_name, null: false
      t.string :photo_id, null: false
      t.string :owner_id
      t.string :owner_name
      t.string :title
      t.decimal :lat, null: false
      t.decimal :lng, null: false
      t.string :accuracy
      t.string :place_id
      t.string :url_z, null: false
      t.string :height_z, null: false
      t.string :width_z, null: false
      t.string :date_uploaded
      t.string :date_taken_string
      t.datetime :date_taken
      t.string :taken_granularity
      t.string :photo_page_url
    end
  end
end
