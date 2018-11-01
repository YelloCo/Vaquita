class ChangeUserToAssigneeColumnOnReviews < ActiveRecord::Migration[5.1]
  def change
    remove_column :reviews, :user_id
    add_column :reviews, :completed_by, :integer
  end
end
