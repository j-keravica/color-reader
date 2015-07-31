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

  describe "#start" do

    it "periodically sends the words with the color information" do
      @scheduler = WordScheduler.new(60, ["Some", "words"], "b")
      ENV["COLOR_URL"] = "test"

      expect(RestClient).to receive(:post).with(ENV["COLOR_URL"] + '/color', {:word => "Some", :color => "b"})
      expect(RestClient).to receive(:post).with(ENV["COLOR_URL"] + '/color', {:word => "words", :color => "b"})

      @scheduler.start
      sleep 2.5
    end

    it "returns the sending job's id" do
      @scheduler = WordScheduler.new(60, ["Some", "words"], "b")
      ENV["COLOR_URL"] = "test"
      @scheduler.start
      expect(@scheduler.job_id).to_not be_nil
    end

  end

  describe "#pause" do

    before do
      @job = double("job")
      allow(@job).to receive(:pause)
      allow(Rufus::Scheduler.singleton).to receive(:job).with(123) { @job }
    end

    context "job is running" do

      before do
        allow(@job).to receive(:paused?) { false }
      end

      it "pauses a job" do
        expect(@job).to receive(:pause)
        WordScheduler.pause(123)
      end

    end

    context "job is already paused" do

      before do
        allow(@job).to receive(:paused?) { true }
      end

      it "will not pause the job" do
        expect(@job).to_not receive(:pause)
        WordScheduler.pause(123)
      end

    end

  end

  describe "#resume" do

    before do
      @job = double("job")
      allow(@job).to receive(:resume)
      allow(Rufus::Scheduler.singleton).to receive(:job).with(123) { @job }
    end

    context "job is paused" do

      before do
        allow(@job).to receive(:paused?) { true }
      end

      it "resumes a job" do
        expect(@job).to receive(:resume)
        WordScheduler.resume(123)
      end

    end

    context "job is already running" do

      before do
        allow(@job).to receive(:paused?) { false }
      end

      it "won't resume the job" do
        expect(@job).to_not receive(:resume)
        WordScheduler.resume(123)
      end

    end

  end

end
