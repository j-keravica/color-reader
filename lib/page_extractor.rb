require 'open-uri'

class PageExtractor

  def self.extract_page(url)
    if valid_format_url(url)
      if reachable_url(url)
        self.new(url)
      else
        raise "URL cannot be reached"
      end
    else
      raise "URL format is not valid"
    end
  end

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

  def self.valid_format_url(url)
    uri = URI.parse(url)
    uri.kind_of?(URI::HTTP)
  rescue URI::Error
    false
  end

  def self.reachable_url(url)
    res = RestClient.head(url)
    res.code == 200
  rescue RestClient::Exception
    false
  end

end
