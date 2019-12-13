class AddDefaultLocationAndAvatarToOrg < ActiveRecord::Migration[5.2]
  def change
    change_column_default(:organizations, :location, {:from=>nil, :to=>""})
    change_column_default(:organizations, :avatar_url, {:from=>nil, :to=>"default_avatar.png"})
  end
end
