class Page < ActiveRecord::Base

  belongs_to :user
  validates :url, :presence => true
  validates :text

  def words
    unless text.present?
      RestClient.post(
        ENV["EXTRACT_URL"),
        {
          :url => url
        }
      )
      response = JSON.parse(response)
      update_attributes!(:text => response["text"])
    else
      text
    end
  end

end
