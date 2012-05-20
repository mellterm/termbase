class CreateAuthorities < ActiveRecord::Migration
  def change
    create_table :authorities do |t|
      t.integer :authoritable_id
      t.string :authoritable_type

      t.timestamps
    end
  end
end
