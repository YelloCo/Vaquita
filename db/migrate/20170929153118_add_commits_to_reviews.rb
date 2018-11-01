class AddCommitsToReviews < ActiveRecord::Migration[5.1]
  def change
    add_column :reviews, :beginning_commit, :string
    add_column :reviews, :ending_commit, :string
  end
end
