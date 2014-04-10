class CreateEvents < ActiveRecord::Migration
  def up
    create_table :events do |t|
      t.integer "type_id"
      t.integer "user_id"
      t.integer "locality_id"
      t.string "name", :null => false
      t.date "date"
      t.time "time"
      t.text "description"
      t.integer "ticket_price"
      t.string "fb_id_number"
      t.string "url_link"
      t.timestamps
    end

    add_index("events","type_id")     #vyhladavanie podla typu
    add_index("events","date")        #vyhladavanie podla datumu
    add_index("events","name")        #vyhladavanie podla mena
  end

  def down
    drop_table :events
  end
end
