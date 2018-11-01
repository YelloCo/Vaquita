class CreateReviewIssues < ActiveRecord::Migration[5.1]
  def change
    create_table :review_issues do |t|
      t.string :title
      t.text :description
      t.string :tracking_url
      t.references :review, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
