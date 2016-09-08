require "rails_helper"

RSpec.describe Page do

  it { is_expected.to have_db_column(:url) }
  it { is_expected.to have_db_column(:title) }
  it { is_expected.to have_db_column(:text) }

  it { is_expected.to have_db_index(:user_id) }
  it { is_expected.to belong_to(:user) }

  it { is_expected.to validate_presence_of(:url) }

  before do
    @page = Page.create(:url => "abc")
  end

  describe "#words" do
    before do
      @page.update_attributes!(:text => "Some text")
    end

    it "splits text into words" do
      expect(@page.words).to contain_exactly("Some", "text")
    end
  end

  describe "#text" do
    context "text attribute exists" do
      before do
        @page.update_attributes!(:text => "Some text")
      end

      it "reads attribute from database" do
        text = @page.text
        expect(RestClient).to_not receive(:post)
        expect(text).to eql("Some text")
      end
    end

    context "text attribute doesn't exist" do
      before do
        ENV["EXTRACT_URL"] = "test"
        RestClient = double("RestClient")
        allow(RestClient).to receive(:post)
        allow(JSON).to receive(:parse) { { "text" => "bla" } }
      end

      it "sends post request to fetch the text" do
        expect(RestClient).to receive(:post).with(
          "test",
          :url => "abc",
          :xpath => nil
        )
        text = @page.text
        expect(text).to eql("bla")
      end
    end
  end
end
