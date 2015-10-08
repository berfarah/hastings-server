class ApplicationController < ActionController::Base
  layout 'hastings'
  PER_PAGE = 20.freeze

  def per_page
    PER_PAGE
  end
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
