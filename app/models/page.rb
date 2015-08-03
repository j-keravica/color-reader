class Page < ActiveRecord::Base

  belongs_to :user
  validates :url, :presence => true
  validates :text, :presence => true
  
end
