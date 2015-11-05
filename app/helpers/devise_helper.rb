module DeviseHelper
  def devise_error_messages!
    return "" if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:div, msg) }.join
    content_tag(:div, messages.html_safe, class: "alert alert-danger")
  end
end
