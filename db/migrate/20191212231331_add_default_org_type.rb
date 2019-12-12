class AddDefaultOrgType < ActiveRecord::Migration[5.2]
  def change
    change_column_default(:organizations, :org_type, from: nil, to: "unknown")
  end
end
