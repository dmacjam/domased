class DeleteCity < ActiveRecord::Migration
  def up
    remove_column(:events,:city)
  end

  def down
    add_column(:events,:city,:string)
  end
end
