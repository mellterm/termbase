class CreateRegExes < ActiveRecord::Migration
  def change
    create_table :reg_exes do |t|
      t.integer :language_id
      t.string :regex_category
      t.text :expression
    end
    add_index :reg_exes, :expression
  end
end
