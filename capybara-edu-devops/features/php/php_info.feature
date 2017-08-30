Feature: Looking for php-info

  Scenario: Looking for php-info
    Given I am on "http://localhost"
    Then content "PHP Version 7.0.19" will seen
