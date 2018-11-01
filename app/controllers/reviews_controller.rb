class ReviewsController < ApplicationController
  include FriendlyTimeHelper
  before_action :set_review, only: %w[show edit complete update]

  def index
    reviews = ReviewsFilterService.execute(
      filter: params[:filter],
      sort: params[:sort]
    )
    pagination(reviews.length)
    @reviews = reviews.limit(limit).offset(offset)
  end

  def show
    @time_diff_in_min = (@review.completed_at.to_i - @review.created_at.to_i) / 60
    @time_difference = time_difference(@time_diff_in_min)
  end

  def complete; end

  def edit; end

  def update
    if @review.update(review_params.merge(completed_params))
      redirect_to @review, notice: 'Review was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:status)
  end

  def completed_params
    return {} if @review.completed_at.present?
    { completed_by: current_user.id, completed_at: Time.now }
  end

  def pagination(size)
    @pagination = {
      page: page,
      total_pages: (size / limit.to_f).floor + 1
    }
  end

  def limit
    15
  end

  def page
    params[:page] ? params[:page].to_i : 1
  end

  def offset
    (page - 1) * limit
  end
end
