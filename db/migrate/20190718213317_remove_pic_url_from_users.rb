class RemovePicUrlFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :pic_url, :string
  end
end
