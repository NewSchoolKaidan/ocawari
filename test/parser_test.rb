require "test_helper"
require "ocawari/strategy_delegator"
require "ocawari/parser"

class ParserTest < Minitest::Test
  def test_page_is_set_to_document_if_no_http_error_raised
    VCR.use_cassette "twitter/cp-YURIYA-732424066410274816" do 
      url = "https://twitter.com/CP_yuriya_ist/status/732424066410274816"
      base_parser = Parser.new(URI(url))

      assert_equal Oga::XML::Document, base_parser.send(:page).class
    end
  end

  def test_page_is_set_to_nil_if_url_throws_http_error
    VCR.use_cassette "twitter/kimura-misa-fan-deleted-post" do
      url = "https://twitter.com/earth_JL/status/73204362104252825618k"
      base_parser = Parser.new(URI(url))
      
      assert_equal nil, base_parser.send(:page)
    end
  end
end
