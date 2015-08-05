require "rails_helper"

RSpec.describe "Page Extractor" do

  def valid_format
    allow(UrlValidator).to receive(:valid_format?).and_return(true)
  end

  def reachable_url
    allow(UrlValidator).to receive(:reachable?).and_return(true)
  end

  def invalid_format
    allow(UrlValidator).to receive(:valid_format?).and_return(false)
  end

  def unreachable_url
    allow(UrlValidator).to receive(:reachable?).and_return(false)
  end

  describe "#extract_page" do

    let(:page) { double(ExtractedPage) }

    context "valid url" do
      before do
        valid_format
        reachable_url
        allow(ExtractedPage).to receive(:new).and_return(page)
      end

      it "returns extracted page" do
        PageExtractor.extract_page("some_url")
        expect(page).to_not be_nil
      end
    end

    context "invalid url format" do
      before do
        invalid_format
      end

      it "raises URL exception" do
        expect { PageExtractor.extract_page("some_url") }.to raise_error(Exceptions::InvalidURL, "URL format is not valid")
      end
    end

    context "url unreachable" do
      before do
        valid_format
        unreachable_url
      end

      it "raises URL exception" do
        expect { PageExtractor.extract_page("some_url") }.to raise_error(Exceptions::InvalidURL, "URL cannot be reached")
      end
    end
  end
end
