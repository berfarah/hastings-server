module Hastings
  module ApplicationHelper
    include Components

    def nav_link_to(text, path, controller)
      controllers = controller.is_a?(Array) ? controller : [controller]
      active = ' class="active"' if [params[:action],
                                     params[:controller],
                                     params[:view]].any? { |x| controllers.include? x }
      "<li#{active} title=\"#{text}\">#{link_to text, path}</li>".html_safe
    end

    def search
      url = params[:action] == "index" ? "" : tasks_path

      form_for url, html: { method: :get, role: "search", class: "navbar-form navbar-left" } do
        content_tag :div, class: "form-group" do
          text_field_tag "search", params[:search], size: 50, placeholder: "Search", class: "form-control"
        end
      end
      # form.navbar-form.navbar-left role="search" action=search_url
      #   .form-group: input type="text" class="form-control" placeholder="Search" size="50" name="search_query" value=params[:search_query]
    end

    def about_time(time)
      return time unless time.is_a? Time
      "<time datetime='#{time_default time}' title='#{time_default time}' "\
      "data-toggle='tooltip' data-placement='top'>"\
      "#{time_ago_in_words time} ago</time>".html_safe
    end

    def flash_messages(flash)
      return '' if flash.empty?

      flash.map do |name, msg|
        content_tag :div, msg, class: "alert alert-#{flash_to_bootstrap[name]}"
      end.join.html_safe
    end

    private

      def flash_to_bootstrap
        { 'notice' => 'info',
          'info'   => 'info',
          'success' => 'success',
          'alert' => 'warning',
          'warn' => 'warning',
          'error' => 'danger',
          'exception' => 'danger' }
      end
  end
end
