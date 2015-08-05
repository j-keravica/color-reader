require 'open-uri'

class PageExtractor

  def self.extract_page(url)
    raise Exceptions::InvalidURL, "URL format is not valid" unless UrlValidator.valid_format?(url)
    raise Exceptions::InvalidURL, "URL cannot be reached" unless UrlValidator.reachable?(url)

    page = ExtractedPage.new(url)
  end

end
