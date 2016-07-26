require 'rails_helper'

RSpec.describe PagesController, :type => :controller do

  describe "POST create" do

    before do
      @user = User.create!(
        :username => "sinisa",
        :email => "ab@c.com",
        :password => "12345678"
      )
      allow(controller).to receive(:current_user).and_return(@user)
      allow(WordScheduler).to receive(:start).and_return("123")
    end

    def do_create
      post :create, :page => { :url => "abc" }, :format => 'js'
    end

    it "creates a new page" do
      do_create
      expect(@user.pages.count).to eq(1)
    end

    it "starts the word stream" do
      expect(WordScheduler).to receive(:start)
      do_create
    end

    it "sets the session variable to the current job's id" do
      do_create
      expect(session[:job]).to_not be_nil
    end
  end

  describe "PUT pause" do
    it "pauses the word stream" do
      expect(WordScheduler).to receive(:pause)
      put :pause
      expect(response.status).to eq(200)
    end
  end

  describe "PUT resume" do
    it "resumes the paused word stream" do
      expect(WordScheduler).to receive(:resume)
      put :resume
      expect(response.status).to eq(200)
    end
  end

end
