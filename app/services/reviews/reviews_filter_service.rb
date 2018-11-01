class ReviewsFilterService < Service
  class << self
    private

    def perform(options)
      reviews = Review.select('reviews.*, COUNT(review_issues.id) AS issue_count')
                      .includes(:review_issues, :repository, :user)
                      .left_joins(:review_issues, :repository, :user)
                      .group('reviews.id')
      reviews = apply_filter(options[:filter], reviews) if options[:filter]
      reviews = apply_sort(options[:sort], reviews)
      reviews
    end

    def apply_filter(filter, reviews)
      return reviews if filter[:value].length.zero?
      return reviews unless available_filters.include?(filter[:key].to_s)

      if filter[:value].casecmp('N/A').zero?
        reviews.where(map_filter_columns(filter[:key]) => nil)
      else
        reviews.where("#{map_filter_columns(filter[:key])} LIKE ?", "%#{filter[:value]}%")
      end
    end

    def apply_sort(sort, reviews)
      sort ||= { key: :created_at }
      reviews.order(map_sort_columns(sort[:key]))
    end

    def available_filters
      %w[repository status completed_by]
    end

    def map_filter_columns(key)
      case key.to_s
      when 'repository'
        'repositories.name'
      when 'status'
        'reviews.status'
      when 'completed_by'
        'users.email'
      end
    end

    def map_sort_columns(key)
      case key.to_s
      when 'created_at'
        'reviews.created_at DESC'
      when 'issue_count'
        'issue_count DESC, reviews.created_at DESC'
      end
    end
  end
end
