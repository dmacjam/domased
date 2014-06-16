class AddLoginInfoToUsers < ActiveRecord::Migration
  def change
    change_column :users, :name, :string, limit: 100
    remove_column :users, :password
    remove_column :users, :email
    add_column :users, :uid, :string
    add_column :users, :provider, :string
    add_column :users, :oauth_token, :string
    add_column :users, :oauth_expires_at, :datetime
  end
end
