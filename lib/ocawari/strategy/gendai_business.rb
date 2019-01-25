module Ocawari
  module Strategy
    class GendaiBusiness < Parser

      private

      def parse
        (1..pagination_limit).to_a.reduce([]) do |acc, pagination|
          page = Nokogiri::HTML(open(uri.to_s + "?page=#{pagination}"))

          # Add header image
          if pagination == 1
            acc << File.join("https://gendai.ismedia.jp", page.at("div.articleHeader img")["src"])
          end

          page.css("img.main-image").each do |mainimage|
            acc << File.join("https://gendai.ismedia.jp", mainimage["src"])
          end

          acc
        end
      end

      def pagination_limit
        page.css("div.blockContainer div.pagination li.number").
          map(&:text).
          map(&:strip).
          map(&:to_i).
          max
      end
    end
  end
end