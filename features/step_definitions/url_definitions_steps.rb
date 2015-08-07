def add_pages
  @user.pages.create(:url => "www.somenews.com", :title => "Some news", :text => "Some text")
  @user.pages.create(:url => "www.somethingfunny.com", :title => "Something funny", :text => "Some text")
end

When(/^I go to the listing page$/) do
  visit pages_path
end

Given(/^I have read pages in the past$/) do
  add_pages
end

Then(/^I should see all the pages I have read$/) do
  expect(page).to have_content("Some news")
  expect(page).to have_content("Something funny")
  expect(page).to have_content("www.somenews.com")
  expect(page).to have_content("www.somethingfunny.com")
end
