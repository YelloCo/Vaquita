class AddRawDiffToReviews < ActiveRecord::Migration[5.1]
  def change
    add_column :reviews, :raw_diff, :text
  end
end
