require 'rails_helper'

describe PagesController, :type => :controller do

  describe "POST create" do
    before do
      @user = double(User)
      @page = double(PageExtractor)
      allow(controller).to receive(:current_user).and_return(@user)
      allow(PageExtractor).to receive(:new).and_return(@page)
      allow(@page).to receive(:title)
      allow(@page).to receive(:text)
      allow(@page).to receive_message_chain(:text, :split)
      allow(@user).to receive_message_chain(:pages, :create).and_return(true)
      allow(WordScheduler).to receive(:start).and_return("123")
    end

    it "extracts the text from the page" do
      expect(PageExtractor).to receive(:new).and_return(@page)
      post :create, :page => { :url => "abc" }, :format => 'js'
    end

    it "creates a new page" do
      expect(@user).to receive_message_chain(:pages, :create)
      post :create, :page => { :url => "abc" }, :format => 'js'
    end

    it "starts the word stream" do
      expect(WordScheduler).to receive(:start)
      post :create, :page => { :url => "abc" }, :format => 'js'
    end

    it "sets the session variable to the current job's id" do
      post :create, :page => { :url => "abc" }, :format => 'js'
      expect(session[:job]).to_not be_nil
    end
  end

  describe "PUT pause" do
    it "pauses the word stream" do
      expect(WordScheduler).to receive(:pause)
      get :pause
      expect(response.status).to eq(200)
    end
  end

  describe "PUT resume" do
    it "resumes the paused word stream" do
      expect(WordScheduler).to receive(:resume)
      get :resume
      expect(response.status).to eq(200)
    end
  end

end