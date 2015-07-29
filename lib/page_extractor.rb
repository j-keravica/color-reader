class PageExtractor

  def initialize(url)
    @doc = Nokogiri::HTML(open(url))
  end

  def text
    text = ""
    @doc.xpath('//h1 | //p').each do |node|
        text = text + " " + node.text
    end
    return text
  end

  def title
    @doc.xpath('//title').text
  end

end