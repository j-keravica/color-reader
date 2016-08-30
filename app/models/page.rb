class Page < ActiveRecord::Base

  belongs_to :user
  validates :url, :presence => true

  def words
    text.split
  end

  def text
    self[:text] || fetch_text
  end

  private

  def fetch_text
    response = RestClient.post(
      ENV["EXTRACT_URL"],
      {
        :url => url
      }
    )
    response = JSON.parse(response)
    update_attributes!(:text => response["text"])
    return self.text
  end

end
