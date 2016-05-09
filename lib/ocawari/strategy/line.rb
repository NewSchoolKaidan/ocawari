module Ocawari
  module Strategy
    Line = lambda do |url|
      page = Oga.parse_html(open(url))
      
      css_selector_hierarcy = %w(
        div.article-body
        div.article-body-inner
        img.pict
      ).join(" ")

      image_nodes = page.css(css_selector_hierarcy)

      image_nodes.map do |img|
        img.
          get("src").
          sub("-s.jpg", ".jpg")
      end
    end
  end
end
