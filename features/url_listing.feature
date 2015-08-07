Feature: URL Listing
  A user can see a list of all the pages he has read

  Background:
    Given I am on the home page
    And I am signed in

  Scenario: Listing all of user's previous pages
    Given I have read pages in the past
    When I go to the listing page
    Then I should see all the pages I have read
