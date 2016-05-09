module Ocawari
  module Strategy
    NanaGoGo = lambda do |url|
      page = Oga.parse_html(open(url))
      page.
        css("div.TalkPostDetail__media img").
        map do |img|

        img.get("src")
      end
    end
  end
end
