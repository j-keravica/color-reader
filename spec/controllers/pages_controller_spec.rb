require 'rails_helper'

describe PagesController, :type => :controller do

  describe "POST create" do

    before do
      @user = double(User)
      allow(controller).to receive(:current_user).and_return(@user)
    end

    it "creates a new page" do
      allow(@user).to receive_message_chain(:pages, :create)
    end

  end

  describe "#pause" do
    it "pauses the word stream" do
      expect(WordScheduler).to receive(:pause)
      get :pause
    end
  end

  describe "#resume" do
    it "resumes the paused word stream" do
      expect(WordScheduler).to receive(:resume)
      get :resume
    end
  end

end