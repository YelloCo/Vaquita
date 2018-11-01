class AddActiveFlagToRepositories < ActiveRecord::Migration[5.1]
  def change
    add_column :repositories, :active, :boolean, default: true
  end
end
