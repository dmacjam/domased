class CreateTypesUsers < ActiveRecord::Migration
  def change
    create_table :types_users, id: false do |t|
    	t.belongs_to :type
    	t.belongs_to :user
    end
    add_index :types_users, :user_id 
    add_index :types_users, [:user_id, :type_id], unique: true
  end
end
