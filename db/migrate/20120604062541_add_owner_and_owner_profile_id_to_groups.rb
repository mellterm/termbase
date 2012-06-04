class AddOwnerAndOwnerProfileIdToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :owner_id, :integer
    add_column :groups, :owner_profile_id, :integer

  end
end
