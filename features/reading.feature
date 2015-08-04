Feature: Reading

  Background:
    Given I am on the home page
    And I am signed in

  @javascript
  Scenario:
    When I fill in the form
    Then I should see a message saying the text is being processed

  @javascript
  Scenario:
    When I fill in the form with a bad url
    Then I should see a message saying the url is invalid