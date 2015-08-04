require "rails_helper"

RSpec.describe "Page Extractor" do

  before :each do
    @page = PageExtractor.new(File.join(Rails.root, "spec/lib/example_pages/example.html"))
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

  describe "#valid_format_url" do
    let(:uri) { double("uri") }

    before do
      allow(URI).to receive(:parse).with("some_url") { uri }
    end

    context "url is valid" do
      before do
        allow(uri).to receive(:kind_of?).and_return(true)
      end

      it "returns true" do
        expect(PageExtractor).to receive(:valid_format_url).and_return(true)
        PageExtractor.valid_format_url("some_url")
      end
    end

    context "url is not valid" do
      before do
        allow(uri).to receive(:kind_of?).and_return(false)
      end
      it "returns false" do
        expect(PageExtractor).to receive(:valid_format_url).and_return(false)
        PageExtractor.valid_format_url("some_url")
      end
    end
  end

  describe "#reachable_url" do
    let(:res) { double("res") }

    before do
      allow(RestClient).to receive(:head).with("some_url") { res }
    end

    context "url can be reached" do
      before do
        allow(res).to receive(:code) { 200 }
      end

      it "returns true" do
        expect(PageExtractor).to receive(:reachable_url).and_return(true)
        PageExtractor.reachable_url("some_url")
      end
    end

    context "url cannot be reached" do
      before do
        allow(res).to receive(:code) { 666 }
      end

      it "returns false" do
        expect(PageExtractor).to receive(:reachable_url).and_return(false)
        PageExtractor.reachable_url("some_url")
      end

    end
  end

end
