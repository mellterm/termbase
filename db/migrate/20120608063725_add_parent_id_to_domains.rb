class AddParentIdToDomains < ActiveRecord::Migration
  def change
    add_column :domains, :parent_id, :integer

  end
end
