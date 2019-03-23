class AddFirstNameAndLastNameToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column    :users, :first_name, :string
    add_column    :users, :last_name,  :string
    remove_column :users, :name,       :string

    add_index     :users, :first_name
    add_index     :users, :last_name
  end
end
