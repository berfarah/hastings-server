module Components
  def list_item(title, text, **args)
    header_size = args[:header_size] || 2
    body_size = 8 - header_size

    render partial: component("list_item"),
           locals: { title: title, text: text, body_size: body_size, header_size: header_size }
  end

  def logs_list(logs, header: nil, &block)
    header = block_given? ? capture(&block) : header
    header = header == true ? "Logs" : header
    render partial: "logs/list", locals: { logs: logs, header: header }
  end

  def list_item_link(title, link)
    render partial: component("list_item"),
           locals: { title: title, link: link }
  end

  def glyphicon(icon)
    content_tag :span, nil, class: "glyphicon glyphicon-#{icon}", style: "margin: 2px 5px 0"
  end

  private

    def component(str)
      "components/#{str}"
    end
end
