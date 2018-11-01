class RenameActiveColumnInRepositories < ActiveRecord::Migration[5.1]
  def change
    rename_column :repositories, :active, :is_active
  end
end
