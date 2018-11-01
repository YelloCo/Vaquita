class AddIgnoresColumnToRepositories < ActiveRecord::Migration[5.1]
  def change
    add_column :repositories, :ignores, :text
  end
end
