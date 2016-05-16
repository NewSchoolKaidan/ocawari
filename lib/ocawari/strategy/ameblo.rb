module Ocawari
  module Strategy
    Ameblo = lambda do |uri|
      page = Oga.parse_html(uri.open.read)
      image_nodes = page.css("article a.detailOn img")

      image_nodes.map { |img| img.get("src") }
    end
  end
end
