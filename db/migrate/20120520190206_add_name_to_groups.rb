class AddNameToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :name, :string
    rename_column :groups, :type, :group_type  
  end
end
