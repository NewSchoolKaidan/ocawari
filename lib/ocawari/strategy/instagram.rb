module Ocawari
  module Strategy
    class Instagram < Parser
      def initialize(uri)
        if uri.path =~ /\?taken-by=/
          uri.path = uri.path.sub(/\/\?taken-by=.*/, "")
          @page = Oga.parse_html(open(uri).read)
        else
          @page = Oga.parse_html(open(uri).read)
        end
      rescue OpenURI::HTTPError
        @page = nil
      end
      
      private

      def parse
        meta_node_with_image = page.at_css("meta[property='og:image']")
        image = meta_node_with_image.get("content")

        [image]
      end
    end
  end
end
