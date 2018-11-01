class AddCompletedAtToReview < ActiveRecord::Migration[5.1]
  def change
    add_column :reviews, :completed_at, :timestamp
  end
end
