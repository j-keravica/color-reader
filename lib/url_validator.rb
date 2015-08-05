class UrlValidator

  def self.valid_format?(url)
    uri = URI.parse(url)
    uri.kind_of?(URI::HTTP)
  rescue URI::Error
    false
  end

  def self.reachable?(url)
    res = RestClient.head(url)
    res.code == 200
  rescue RestClient::Exception
    false
  end

end