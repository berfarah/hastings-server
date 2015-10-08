module Components
  def list_item(title, text, **args)
    header_size = args[:header_size] || 2
    body_size = 8 - header_size

    render partial: component("list_item"),
           locals: { title: title, text: text, body_size: body_size, header_size: header_size }
  end

  def list_item_link(title, link)
    render partial: component("list_item"),
           locals: { title: title, link: link }
  end

  def glyphicon(icon)
    "<span class='glyphicon glyphicon-#{icon}' style='margin: 2px 5px 0'></span>".html_safe
  end

  private

    def component(str)
      "components/#{str}"
    end
end
