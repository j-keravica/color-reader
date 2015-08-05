require "rails_helper"

RSpec.describe "URL Validator" do

  describe "#valid_format?" do

    let(:uri) { double("uri") }

    context "url is valid" do

      before do
        allow(URI).to receive(:parse).with("url") { uri }
        allow(uri).to receive(:kind_of?).and_return(true)
      end

      it "returns true" do
        expect(UrlValidator).to receive(:valid_format?).with("url").and_return(true)
        UrlValidator.valid_format?("url")
      end

    end

    context "url is invalid" do

      it "returns false" do
        expect(UrlValidator).to receive(:valid_format?).and_return(false)
        UrlValidator.valid_format?("url")
      end

    end

  end

  describe "#reachable?" do

    let(:res) { double("res") }

    context "url is reachable" do

      before do
        allow(RestClient).to receive(:head).with("some_url") { res }
        allow(res).to receive(:code).and_return(200)
      end

      it "returns true" do
        expect(UrlValidator).to receive(:reachable?).with("some_url").and_return(true)
        UrlValidator.reachable?("some_url")
      end

    end

    context "url is not reachable" do

      it "returns false" do
        expect(UrlValidator).to receive(:reachable?).with("some_url").and_return(false)
        UrlValidator.reachable?("some_url")
      end

    end
    
  end
  
end
