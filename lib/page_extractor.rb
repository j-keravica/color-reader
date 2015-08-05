require 'open-uri'

class PageExtractor

  def self.extract_page(url)
    if UrlValidator.valid_format?(url)
      if UrlValidator.reachable?(url)
        page = ExtractedPage.new(url)
      else
        raise Exceptions::InvalidURL, "URL cannot be reached"
      end
    else
      raise Exceptions::InvalidURL, "URL format is not valid"
    end
  end

end
