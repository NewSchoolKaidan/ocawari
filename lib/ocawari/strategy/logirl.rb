module Ocawari
  module Strategy
    class Logirl < Parser

      private

      def parse
        if json_response["galleries"].nil?
          images = json_response["bodyContainsImageURLs"].map do |url|
            append_https(update_domain(url))
          end
          
          images << append_https(
            update_domain(json_response["thumbnailURL"]).sub("_large", "")
          )

          images
        else
          json_response["galleries"].map do |mediaobj|
            append_https(mediaobj.dig("media", "full", "url"))
          end
        end
      end

      def json_response
        @json_response ||= begin
          article_id = uri.to_s[/\d+/]
          api_endpoint = URI("https://ucon.favclip.com/api/article/#{article_id}?corePortalID=logirl&visibility=site")
          JSON.parse(Net::HTTP.get(api_endpoint))
        end
      end

      def append_https(url_fragment)
        "https:#{url_fragment}"
      end

      def update_domain(url)
        url.sub("ex-chaos.appspot", "ucon.favclip")
      end
    end
  end
end
