class AddRepositoryReferenceToReview < ActiveRecord::Migration[5.1]
  def change
    add_reference :reviews, :repository, foreign_key: true
  end
end
