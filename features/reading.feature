Feature: Reading
  When a user pastes the URL into the URL field and clicks the "Read!" button,
  a corresponding message should appear saying whether the URL is okay
  and the stream is about to start, or the URL is invalid (inappropriate format
  or unreachable).

  Background:
    Given I am on the home page
    And I am signed in

  @javascript
  Scenario: Filling in the form with a valid url
    When I fill in the form with a valid url
    Then I should see a message saying the text is being processed

  @javascript
  Scenario: Filling in the form with an invalid url
    When I fill in the form with a bad url
    Then I should see a message saying the url is invalid

  @javascript
  Scenario: Filling in the form with an unreachable url
    When I fill in the form with a url that cannot be reached
    Then I should see a message saying the url is unreachable
