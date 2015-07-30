require "rails_helper"

describe "Word Scheduler" do

  before :each do
    @scheduler = WordScheduler.new(60, ["These", "are", "some", "nice", "words"], "b")
  end

  it "calculates the time interval for sending words" do
    expect(@scheduler.interval).to eq("1.0s")
  end


  it "sends the words with the color information" do
    ENV["COLOR_URL"] = "test"
    expect(RestClient).to receive(:post).with(ENV["COLOR_URL"] + '/color', {:word => "nesto", :color => "b"})
    @scheduler.send("nesto")
  end

end
