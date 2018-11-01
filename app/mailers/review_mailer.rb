class ReviewMailer < ApplicationMailer
  def review_created(review)
    @review = review
    return if @review.repository.notification_emails.nil?
    mail(
      to: @review.repository.notification_emails,
      subject: "New code review for #{@review.repository.name}"
    )
  end
end
