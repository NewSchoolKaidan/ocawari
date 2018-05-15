module Ocawari
  module Strategy
    class Ameblo < Parser

      private

      CSS_HIERARCHY_SELECTORS = [
        "article a.detailOn img",
        "div.subContentsInner a.detailOn img",
        "div#entryBody.articleText img"
      ]

      def parse
        script_tag = page.css("script").find { |script| script.text.include?("window.INIT_DATA") }
        
        if script_tag
          # Scrape JSON
          image_nodes = script_tag.text.
            split(";window")[0].
            sub("window.INIT_DATA=", "").
            yield_self { |raw| JSON.parse(raw) }.
            dig("entryState", "entryMap", entry_id, "entry_text").
            yield_self { |html_fragment| Nokogiri::HTML(html_fragment) }.
            yield_self { |document| document.css("img") }.
            select { |img| img["src"].include?("/user_images/") }

          image_nodes.map do |img|
            case img["src"]
            when /t\d+_/
              img["src"].sub(/\/t\d+_/, "/o")
            when /\?caw=800$/
              img["src"].sub(/\?caw=800/, "")
            else
              img["src"]
            end
          end
        else
          # Scrape HTML
          page.css(CSS_HIERARCHY_SELECTORS.join(", ")).reduce([]) do |images, node|
            if /\.jpg|\.png/i.match?(node["src"])
              highest_resolution = node["src"].sub(/\/t\d+_/, "/o")
              images << highest_resolution
            else
              images
            end
          end
        end
      end


      def entry_id
        uri.basename.sub("entry-", "").sub(".html", "")
      end
    end
  end
end