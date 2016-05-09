module Ocawari
  module Strategy
    Line = lambda do |url|
      page = Oga.parse_html(open(url))
      image_nodes = page.css("div.article-body div.article-body-inner img.pict")

      image_nodes.map { |img| img.get("src").sub("-s.jpg", ".jpg") }
    end
  end
end
