class ApplicationController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery with: :exception
  before_action :page_title, :authenticate_user!

  def page_title
    @page_title ||= find_page_title
  end
end
