class Review < ApplicationRecord
  has_many :review_issues
  belongs_to :repository, -> { unscope(where: :is_active) }
  belongs_to :user, -> { unscope(where: :is_active) }, foreign_key: :completed_by, optional: true

  after_create :send_review_email

  private

  def send_review_email
    ReviewMailer.review_created(self).deliver_now
  end
end
