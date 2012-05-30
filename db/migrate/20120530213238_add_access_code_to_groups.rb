class AddAccessCodeToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :access_code, :string
  end
end
