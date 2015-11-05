module ApplicationHelper
  include Components

  def nav_link_to(text, path, controller)
    controllers = controller.is_a?(Array) ? controller : [controller]
    active = ' class="active"' if [params[:action],
                                   params[:controller],
                                   params[:view]].any? { |x| controllers.include? x }
    "<li#{active}>#{link_to text.html_safe, path}</li>".html_safe
  end

  def search
    form_for :logs, url: { controller: "/logs", action: "search" }, html: { method: :get, role: "search", class: "navbar-form navbar-left navbar-search" } do
      content_tag :div, class: "form-group" do
        concat text_field_tag :query, params[:query], size: 50, placeholder: "Search#{" "+search_name unless search_name.blank?} logs", class: "form-control"
        concat hidden_field_tag :name, search_name unless search_name.blank?
        concat hidden_field_tag :searching, searching
        concat hidden_field_tag :from, params[:from] unless params[:from].blank?
        concat hidden_field_tag :to, params[:to] unless params[:to].blank?
        concat content_tag :i, nil, class: "glyphicon glyphicon-search"
      end
    end
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

    def search_name
      params[:name] || params[:action] == "show" && class_for_search_name
    end

    def class_for_search_name
      @class_for_search_name ||= params[:controller].classify.constantize.find(params[:id]).name
    end

    def searching
      params[:searching] || params[:controller]
    end

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
