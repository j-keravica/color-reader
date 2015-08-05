require "rails_helper"

RSpec.describe "Extracted Page" do

  before :each do
    @page = ExtractedPage.new(File.join(Rails.root, "spec/lib/example_pages/example.html"))
  end

  describe "#text" do
    it "returns text from p and h1 HTML elements" do
      expect(@page.text).to include("It’s okay to be angry and to be kind of dark")
    end
  end

  describe "#title" do
    it "returns the title from the web page" do
      expect(@page.title).to include("Stop Trying To Inspire Me")
    end
  end

end