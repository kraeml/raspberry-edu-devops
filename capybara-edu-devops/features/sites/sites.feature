Feature: Looking for websites on raspberry

  Scenario: Looking for websites
    Given I am on http://localhost:<port>
    Then content <content> will seen

    websites:
    | port | content            |
    | 80   | PHP Version 7.0.19 |
