class CreateEvents < ActiveRecord::Migration
  def up
    create_table :events do |t|
      t.integer "type_id", :default => 0
      t.integer "user_id"
      t.string "name", :null => false
      t.datetime "date"
      t.string "city"
      t.string "address"
      t.float "latitude"
      t.float "longitude"
      t.text "description"
      t.integer "ticket_price"
      t.string "fb_id_number"
      t.string "url_link"
      t.timestamps
    end

=begin
    add_index("events","type_id")     #vyhladavanie podla typu
    add_index("events","date")        #vyhladavanie podla datumu
    add_index("events","name")        #vyhladavanie podla mena
=end
  end

  def down
    drop_table :events
  end
end
