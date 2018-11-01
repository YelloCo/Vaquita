class AddColumnsToReviews < ActiveRecord::Migration[5.1]
  def change
    add_column :reviews, :name, :string
    add_column :reviews, :file, :string
    add_column :reviews, :status, :string
  end
end
