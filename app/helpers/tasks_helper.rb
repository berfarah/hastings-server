module TasksHelper
  def enabled(bool)
    cls = bool ? 'check' : 'unchecked'
    content_tag :span, nil, class: "glyphicon glyphicon-#{cls}", style: ""
  end
end
