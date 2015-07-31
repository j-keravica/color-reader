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

  describe "#start_sending" do

    it "periodically sends the words with the color information" do
      @scheduler = WordScheduler.new(60, ["Some", "words"], "b")
      ENV["COLOR_URL"] = "test"

      expect(RestClient).to receive(:post).with(ENV["COLOR_URL"] + '/color', {:word => "Some", :color => "b"})
      expect(RestClient).to receive(:post).with(ENV["COLOR_URL"] + '/color', {:word => "words", :color => "b"})

      @scheduler.start_sending
      sleep 2.5
    end

    it "returns the sending job's id" do
      @scheduler = WordScheduler.new(60, ["Some", "words"], "b")
      ENV["COLOR_URL"] = "test"
      @scheduler.start_sending
      expect(@scheduler.job_id).to_not be_nil
    end

  end

end
