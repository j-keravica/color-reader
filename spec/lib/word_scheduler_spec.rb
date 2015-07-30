require "rails_helper"

describe "Word Scheduler" do

  describe "#interval" do

    it "calculates the time interval for sending words" do
      examples = [
        { :input => 60, :result => "1.0s" },
        { :input => 100, :result => "0.6s" },
        { :input => 200, :result => "0.3s" }
      ]
      examples.each do |example|
        input = example[:input]
        @scheduler = WordScheduler.new(input, [], "b")
        expect(@scheduler.interval).to eq(example[:result])
      end
    end

  end


  describe "#send" do

    it "sends the words with the color information" do
      @scheduler = WordScheduler.new(60, [], "b")
      ENV["COLOR_URL"] = "test"
      expect(RestClient).to receive(:post).with(ENV["COLOR_URL"] + '/color', {:word => "word", :color => "b"})
      @scheduler.send("word")
    end

  end

end
