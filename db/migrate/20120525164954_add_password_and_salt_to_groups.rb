class AddPasswordAndSaltToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :encrypted_secure_code, :string
    add_column :groups, :salt, :string
  end
end
