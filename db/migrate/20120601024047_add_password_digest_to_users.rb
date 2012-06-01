class AddPasswordDigestToUsers < ActiveRecord::Migration
    def change
      remove_column :users, :encrypted_password
      remove_column :users, :salt
      remove_column :users, :auth_token
      remove_column :users, :password_reset_token 
      remove_column :users, :password_reset_sent_at
      add_column :users, :password_digest, :string
    end
end
