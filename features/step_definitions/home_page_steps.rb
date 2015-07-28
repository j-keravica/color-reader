def define_user
	@user = { username: "user", email: "user@example.com", password: "password" }
end

def register_user
  #create_user
  click_link('Sign up')
  fill_in("user_email", :with => @user[:email])
  fill_in("user_username", :with => @user[:username])
  fill_in("user_password", :with => @user[:password])
  fill_in("user_password_confirmation", :with => @user[:password])
  click_button('Sign up')
end

def login_user
  #create_user
  click_link('Sign in')
  fill_in("user_email", :with => @user[:email])
  fill_in("user_password", :with => @user[:password])
  click_button('Log in')
end

Given(/^I am on the home page$/) do
  visit root_path
end

Given(/^I am not signed in$/) do
  
end

Then(/^I should see Register link$/) do
  expect(page).to have_link 'Sign up', href: new_user_registration_path
end

Then(/^I should see the Sign in link$/) do
  expect(page).to have_link 'Sign in', href: new_user_session_path
end

When(/^I register$/) do
  define_user
  register_user
end

Given(/^I am signed in$/) do
  define_user
  User.create(@user)
  login_user
end

Then(/^I should see my username at the top$/) do
  expect(page).to have_content "Signed in as " + @user[:username]
end

Then(/^I should see the Sign out link$/) do
  expect(page).to have_link 'Sign out'
end

When(/^I click the Sign out link$/) do
  click_link('Sign out')
end

Then(/^I should be signed out$/) do
  expect(page).to have_link 'Sign in', href: new_user_session_path
  expect(page).to have_link 'Sign up', href: new_user_registration_path
end

