class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string "username", :limit => 25
      t.string "name", :limit =>40
      t.string "email", :default => "", :null => false
      t.string "password", :limit => 40
      t.integer "ranking", :default => 0
      t.text "profile_text"
      t.timestamps
    end
  end

  def down
    drop_table :users
  end
end
