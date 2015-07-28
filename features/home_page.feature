Feature: Home page

  Background:
    Given I am on the home page

  Scenario: Viewing application's home page as a visitor
    Given I am not signed in
    Then I should see Register link
    And I should see the Sign in link

  Scenario: Registering
  	Given I am not signed in
  	When I register
  	Then I should see my username at the top
  	And I should see the Sign out link

  Scenario: Viewing application's home page as a signed in user
  	Given I am signed in
  	Then I should see my username at the top
  	And I should see the Sign out link

  Scenario: Signing out
    Given I am signed in
    When I click the Sign out link
    Then I should be signed out
