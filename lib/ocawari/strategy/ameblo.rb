module Ocawari
  module Strategy
    Ameblo = lambda do |url|
      page = Oga.parse_html(open(url))
      image_nodes = page.css("article a.detailOn img")

      image_nodes.map { |img| img.get("src") }
    end
  end
end
