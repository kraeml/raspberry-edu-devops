Feature: Looking for websites on raspberry

  Scenario Outline: Checking all pages
    When I go on the page "http://localhost:<port>"
    # Then the page has no HTTP error response
    And see the content of "<content>"
      Examples:
        | port | content            |
        | 80   | PHP Version 7.0.19 |
