class AddUniquenessIndexes < ActiveRecord::Migration
    def change
       add_index :users, :email, :unique => true
       add_index :translations, [:source_content, :target_content, :created_by_id, :group_id], :unique => true, :name => 'unique_trans_user_and_group'
    end
end
