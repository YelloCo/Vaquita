class ReviewIssuesController < ApplicationController
  def index; end

  def show; end

  def edit; end

  def destroy
    review_issue.destroy!
    redirect_back(fallback_location: edit_review_path(@review_issue.review))
  end

  def create
    @review_issue = ReviewIssue.new(review_issue_params)
    @review_issue.user = current_user
    @review_issue.save!

    redirect_back(fallback_location: edit_review_path(@review_issue.review))
  end

  private

  def review_issue
    @review_issue ||= ReviewIssue.find(params['id'])
  end

  def review_issue_params
    params.require(:review_issue).permit(:review_id, :title, :description, :tracking_url)
  end
end
