module Ocawari
  module Strategy
    TokyoIdolNet = lambda do |url|
      page = Oga.parse_html(open(url))
      page.css("img").map do |img|
        img.get("data-large-file")
      end.compact
    end
  end
end
