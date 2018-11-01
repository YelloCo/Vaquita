module ReviewsHelper
  def page_query(page)
    safe_params = params.permit(:page, :utf8, filter: %i[key value], sort: %i[key])
    reviews_path(safe_params.merge(page: page))
  end
end
