module Ocawari
  module Strategy
    class Logirl < Parser

      private

      def parse
        article_id = uri.to_s[/\d+/]
        api_endpoint = URI("https://ucon.favclip.com/api/article/#{article_id}?corePortalID=logirl&visibility=site")
        json_response = JSON.parse(Net::HTTP.get(api_endpoint))

        json_response["galleries"].map do |mediaobj|
          "https:#{mediaobj.dig("media", "full", "url")}"
        end
      end
    end
  end
end
