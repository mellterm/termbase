class AddIsPublicToTranslations < ActiveRecord::Migration
  def change
    add_column :translations, :is_public, :boolean, :default => true

  end
end
