class Parser
  def initialize(uri)
    @uri = uri
    @page = Oga.parse_html(open(uri).read)
  rescue OpenURI::HTTPError
    @page = nil
  end

  def execute
    if page.nil?
      []
    else
      parse
    end
  end

  private

  attr_reader :page, :uri
end
