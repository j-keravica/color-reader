require "rails_helper"

RSpec.describe "Word Scheduler" do

  describe "#interval" do

    it "calculates the time interval for sending words" do
      examples = [
        { :input => 60, :result => "1.0s" },
        { :input => 100, :result => "0.6s" },
        { :input => 200, :result => "0.3s" }
      ]
      examples.each do |example|
        input = example[:input]
        @scheduler = WordScheduler.new([], input)
        expect(@scheduler.interval).to eq(example[:result])
      end
    end

  end

  describe "#start" do

    before do
      @page = instance_double(Page, :url => "www.bla.com")
      allow(@page).to receive(:words) { ["Some", "words"] }
    end

    it "periodically sends the words with the color information" do
      ENV["SEND_URL"] = "test"

      expect(RestClient).to receive(:post).with(
        ENV["SEND_URL"],
        { :word => "Some", :channel => "test_channel" }
      )
      expect(RestClient).to receive(:post).with(
        ENV["SEND_URL"],
        { :word => "words", :channel => "test_channel" }
      )

      WordScheduler.start(@page, 60)
      sleep 2.5
    end

    it "returns the sending job's id" do
      ENV["SEND_URL"] = "test"
      job_id = WordScheduler.start(@page, 60)
      expect(job_id).to_not be_nil
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
