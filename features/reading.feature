Feature: Reading

  Background:
    Given I am on the home page
    And I am signed in

  Scenario:
    When I fill in the form
    Then I should see a message saying the text is being processed