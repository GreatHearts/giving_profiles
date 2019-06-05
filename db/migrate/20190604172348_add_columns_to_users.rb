class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :remember_created_at, :timestamp
    add_column :users, :avatar_url, :string
  end
end
