module Ocawari
  module Strategy
    class NewsDwango < Parser

      private

      def parse
        script = page.css("script").find do |script|
          /Config\.post/.match?(script.text)
        end        

        scrubbed_json = script.text.
                          gsub(/[[:space:]]/, "").
                          sub("window.jpnewsConfig.post=", "").
                          sub(/;window\.jpnewsConfig\.prPosts.*$/, "") 

        metadata = JSON.parse(scrubbed_json)

        [metadata.dig("main_image", "full", "url")] + metadata["child_images"].map do |child_image|
          child_image.dig("full", "url")
        end
      end
    end
  end
end
