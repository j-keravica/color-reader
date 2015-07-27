Feature: Home page

  Scenario: Viewing application's home page as a visitor
    Given I am on the home page
    And I am not signed in
    Then I should see Register link
    And I should see the Sign in link
