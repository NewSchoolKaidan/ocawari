module Ocawari
  module Strategy
    class Ameblo < Parser

      private

      CSS_HIERARCHY_SELECTORS = [
        "article a.detailOn img",
        "div.subContentsInner a.detailOn img"
      ]

      def parse
        script_tag = page.css("script").find { |script| script.text.include?("window.INIT_DATA") }

        image_nodes = script_tag.text.
          split(";window")[0].
          sub("window.INIT_DATA=", "").
          yield_self { |raw| JSON.parse(raw) }.
          dig("entryState", "entryMap", entry_id, "entry_text").
          yield_self { |html_fragment| Nokogiri::HTML(html_fragment) }.
          yield_self { |document| document.css("img") }.
          select { |img| img["src"].include?("/user_images/") }

        image_nodes.map do |img|
          image_source = img["src"]
          case image_source
          when /t\d+_/
            image_source.sub(/t\d+_/, "o")
          when /\?caw=800$/
            image_source.sub(/\?caw=800/, "")
          else
            image_source
          end
        end
      end


      def entry_id
        uri.to_s.split("/").last.sub("entry-", "").sub(".html", "")
      end
    end
  end
end
