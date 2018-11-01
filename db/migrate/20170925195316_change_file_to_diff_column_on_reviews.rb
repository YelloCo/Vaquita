class ChangeFileToDiffColumnOnReviews < ActiveRecord::Migration[5.1]
  def change
    remove_column :reviews, :file
    add_column :reviews, :diff, :text
  end
end
