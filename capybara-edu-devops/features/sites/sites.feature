Feature: Looking for websites on raspberry

  Scenario Outline: Checking all pages
    When I go on the page "http://localhost:<port>/<path>"
    # Then the page has no HTTP error response
    And see the content of "<content>"
      Examples:
        | port | content            | path |
        | 80   | PHP Version 7.0.19 |      |
        | 80   | Willkommen bei phpMyAdmin | phpMyAdmin/ |
        | 80   | Index of /~pi/     | ~pi  |
        | 8888 | Password:          |      |
        | 1880 | Raspberr Pi        |      |
        | 9001 | oder ein Pad mit folgendem Namen |      |
        | 8181 | Welcome to Cloud9  |      |

# ToDo Port 9002 etherdraw; Jupyter login
