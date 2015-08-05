class ExtractedPage

  def initialize(url)
    @doc = Nokogiri::HTML(open(url).read)
  end

  def text
    @doc.xpath('//h1 | //p').reduce("") do |text, node|
      text = text + " " + node.text
    end
  end

  def title
    @doc.xpath('/html/head/title').text
  end

end