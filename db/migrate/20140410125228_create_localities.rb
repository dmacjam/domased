class CreateLocalities < ActiveRecord::Migration
  def up
    create_table :localities do |t|
      t.string "adress"
      t.float "lattitude"
      t.float "altitude"
      t.timestamps
    end
  end

  def down
    drop_table :localities
  end
end
