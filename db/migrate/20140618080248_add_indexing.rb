class AddIndexing < ActiveRecord::Migration
  def change
  	add_index :users, :provider
  	add_index :users, :uid
  	add_index :events, :date
  	add_index :events, :type_id
  	add_index :types, [:id,:name], unique:true
  	add_index :types, :name
  end
end
