class CreateFacebookPlaces < ActiveRecord::Migration
  def change
    create_table :facebook_places do |t|
      t.string :place_id, unique: true, null: false
      t.string :name
      t.timestamps
    end
  end
end
