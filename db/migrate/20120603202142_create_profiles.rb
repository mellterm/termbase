class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.string :real_name, :null => false
      t.date :birthday  
      t.integer :native_language_id, :null => false 
      t.text :bio
      t.integer :badge_id, :null => false
      t.integer :location_id
      t.integer :user_id, :null => false
      t.timestamps
    end
      add_index :profiles, [:user_id, :badge_id], :name => :user_badge_unique_index, :unique => true
  end

  def self.down
    remove_index(:profiles, :name => :user_badge_unique_index)
    drop_table :profiles
  end
end
