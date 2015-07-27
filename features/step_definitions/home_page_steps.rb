Given(/^I am on the home page$/) do
  visit root_path
end

Given(/^I am not signed in$/) do
  
end

Then(/^I should see Register link$/) do
  expect(page).to have_link 'Sign up',
  href: new_user_registration_path
end

Then(/^I should see the Sign in link$/) do
  expect(page).to have_link 'Sign in',
  href: new_user_session_path
end

