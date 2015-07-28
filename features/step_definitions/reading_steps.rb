Given(/^I am on the reading page$/) do
  visit root_path
end

When(/^I fill in the form$/) do
  fill_in("page_url", :with => "http://www.manrepeller.com/2015/07/dream-job.html")
  select '60 wpm', from: 'page_speed'
  select 'b', from: 'page_color'
end

When(/^press the Read button$/) do
  click_button('Read!')
end

Then(/^I should see a message saying the text is being processed$/) do
  expect(page).to have_selector '.flash'
end
