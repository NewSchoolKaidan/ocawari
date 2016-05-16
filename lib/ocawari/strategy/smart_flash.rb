module Ocawari
  module Strategy
    SmartFlash = lambda do |uri|
      page = Oga.parse_html(uri.open.read)
      
      css_selector_hierarcy = %w(
        div#main
        div.section
        div.inner
        img
      ).join(" ")

      page.css(css_selector_hierarcy).map do |img|
        img.get("src")
      end.select do |url|
        url =~ /data\.smart-flash\.jp/
      end
    end
  end
end
