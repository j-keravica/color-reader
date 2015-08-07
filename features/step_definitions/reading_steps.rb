require "pusher-fake/support/cucumber"

Given(/^I am on the reading page$/) do
  visit root_path
end

When(/^I fill in the form with a valid url$/) do
  fill_in("page_url", :with => "http://www.manrepeller.com/2015/07/dream-job.html")
  select '60 wpm', from: 'page_speed'
  select 'b', from: 'page_color'
  click_button("Read!")
end

Then(/^I should see a message saying the text is being processed$/) do
  expect(page).to have_content "Your text stream will start in a few moments"
end

Then(/^I should see the first word being displayed$/) do
  Pusher.trigger("test_channel", "my_event", { :word => "Pusher", :color => "#000000" })
  expect(page).to have_content "Pusher"
end

When(/^I fill in the form with a bad url$/) do
  fill_in("page_url", :with => "nonsense")
  select '60 wpm', from: 'page_speed'
  select 'b', from: 'page_color'
  click_button("Read!")
end

Then(/^I should see a message saying the url is invalid$/) do
  expect(page).to have_content "URL format is not valid"
end

When(/^I fill in the form with a url that cannot be reached$/) do
  fill_in("page_url", :with => "https://medium.com/@Storyful/production-company")
  select '60 wpm', from: 'page_speed'
  select 'b', from: 'page_color'
  click_button("Read!")
end

Then(/^I should see a message saying the url is unreachable$/) do
  expect(page).to have_content "URL cannot be reached"
end

