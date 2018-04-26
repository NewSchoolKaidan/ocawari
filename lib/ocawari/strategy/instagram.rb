module Ocawari
  module Strategy
    class Instagram < Parser
      def initialize(uri)
        if /\?taken-by=/.match?(uri.path)
          uri.path = uri.path.sub(/\/\?taken-by=.*/, "")
          @page = Nokogiri::HTML(open(uri).read)
        else
          @page = Nokogiri::HTML(open(uri).read)
        end
      rescue OpenURI::HTTPError
        @page = nil
      end
      
      private

      def parse
        script_tag = page.css("script").find { |script| script.text.include?("window._sharedData") }

        graphql_state = script_tag.text.
          sub("window._sharedData = ", "").
          sub(/;$/, "").
          yield_self { |raw| JSON.parse(raw) }

        root = graphql_state.dig( "entry_data", "PostPage", 0, "graphql", "shortcode_media")

        if graph_images_nodes = root.dig("edge_sidecar_to_children", "edges")
          graph_images_nodes.map do |graph_image| 
            graph_image.dig("node", "display_url")
          end
        else
          # Largest width & height resolution is 1080x1080
          # Greater than 750 is an attempt at future proofing
          root["display_resources"].find do |image|
            image["config_width"] > 750 &&
            image["config_height"] > 750
          end.
          fetch("src").
          yield_self { |src| [src].compact }
        end
      end
    end
  end
end