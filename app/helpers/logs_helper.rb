module LogsHelper
  def of_name
    return if params[:name].blank? || params[:searching].blank?
    thing = params[:searching].classify.constantize.find_by(name: params[:name])
    ' for '.html_safe <<
      link_to(params[:name], controller: params[:searching], action: :show, id: thing.id)
  end

  def severity_class(severity)
    { info: '',
      warn: 'text-warning',
      error: 'text-danger',
      fatal: 'text-danger danger' }[severity.to_sym]
  end

  def date_range
    form_for :logs, url: { controller: :logs, action: "search" }, html: { method: :get, role: "search", class: "navbar-form navbar-left navbar-search", style: "padding-right: 0" } do
      concat hidden_field_tag "query", params[:query] unless params[:query].blank?
      concat hidden_field_tag "name", search_name unless search_name.blank?
      concat(content_tag(:div, class: "form-group") {
        concat label_tag :from, "From", class: "control-label", style: "margin-right: 5px"
        concat date_field_tag :from, params[:from], class: 'form-control form-date'
      })

      concat(content_tag(:div, class: "form-group") {
        concat label_tag :to, "To", class: "control-label", style: "margin-right: 5px"
        concat date_field_tag :to, params[:to], class: 'form-control form-date'
      })

      concat button_tag "Filter", class: "btn btn-sm   btn-default", name: ""
    end
  end

  def time_to_complete(duration)
    return unless duration
    'Took ' << duration.human_time << ' to complete'
  end

  def time_format(time)
    return unless time
    I18n.l time.localtime, format: :human
  end

  def time_default(time)
    I18n.l time.localtime, format: :default
  end
end
