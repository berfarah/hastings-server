module Hastings
  module Components
    def list_item(title, text)
      render partial: component("list_item"),
             locals: { title: title, text: text }
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
        "hastings/components/#{str}"
      end
  end
end
