Feature: Looking for user pi homepage

  Scenario: Looking for pi home page
    Given I am on "http://localhost/~pi"
    Then content "Index of /~pi/" will seen
