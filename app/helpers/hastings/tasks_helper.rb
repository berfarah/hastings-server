module Hastings
  module TasksHelper
    def sd(runtime)
      runtime.last
    end

    def average(runtime)
      runtime.first
    end

    def enabled(bool)
      cls = bool ? 'check' : 'unchecked'
      content_tag :span, nil, class: "glyphicon glyphicon-#{cls}", style: ""
    end
  end
end
