Feature: Home page

  Scenario: Viewing application's home page as a visitor
    Given I am on the home page
    And I am not signed in
    Then I should see Register link
    And I should see the Sign in link

  Scenario: Registering
  	Given I am on the home page
  	And I am not signed in
  	When I register
  	Then I should see my username at the top
  	And I should see the Sign out link

  Scenario: Viewing application's home page as a signed in user
  	Given I am on the home page
  	And I am signed in
  	Then I should see my username at the top
  	And I should see the Sign out link
