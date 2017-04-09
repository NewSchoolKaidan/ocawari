module Ocawari
  module Strategy
    class ModelPress < Parser

      private

      BASE_URL = "https://mdpr.jp".freeze
      CSS_SELECTORS = [
        "div.content-moki a.photo-detail-link"
      ]

      def parse
        image_links = page.css(CSS_SELECTORS.join(", ")).map do |image|
          "#{BASE_URL}#{image.get("href")}"
        end

        image_links.map do |link|
          page = Oga.parse_html(open(link))

          url_fragment = page.at_css(".main-photo img.outputthumb").get("src")

          already_contains_host = /^https?/.match?(url_fragment) && /mdpr\.jp/.match?(url_fragment)


          if already_contains_host
            url_fragment
          else
            "#{BASE_URL}#{url_fragment}"
          end
        end
      end
    end
  end
end
