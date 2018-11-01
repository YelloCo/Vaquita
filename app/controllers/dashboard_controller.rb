class DashboardController < ApplicationController
  include FriendlyTimeHelper
  def index
    @repositories = Repository.includes(reviews: :review_issues)
                              .collect { |r| dashboard_attributes(r) }
  end

  private

  def dashboard_attributes(repo)
    avg_time = average_review_completion(repo)
    {
      name: repo.name,
      outstanding_count: repo.reviews.where.not(status: 'Completed').count,
      completed_count: repo.reviews.where(status: 'Completed').count,
      avg_time: avg_time,
      avg_time_string: time_difference(avg_time),
      issues_found: repo.reviews.sum { |r| r.review_issues.size }
    }
  end

  def average_review_completion(repo)
    times = repo.reviews.where.not(completed_at: nil).order('completed_at DESC').collect do |review|
      # Time difference in minutes
      (review.completed_at - review.created_at).to_i / 60
    end
    return 0 if times.empty?
    times[0..13].reduce(:+) / times[0..13].size
  end
end
