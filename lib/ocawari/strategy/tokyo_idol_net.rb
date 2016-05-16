module Ocawari
  module Strategy
    TokyoIdolNet = lambda do |uri|
      page = Oga.parse_html(uri.open.read)
      page.css("img").map do |img|
        img.get("data-large-file")
      end.compact
    end
  end
end
