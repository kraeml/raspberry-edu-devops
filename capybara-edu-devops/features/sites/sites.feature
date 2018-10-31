Feature: Looking for websites on raspberry

  Scenario Outline: Checking all pages
    When I go on the page "http://localhost:<port>/<path>"
    Then see the content of "<content>"
      Examples:
        | port | content            | path |
        | 80   | PHP Version 7.     |      |
        | 80   | Willkommen bei phpMyAdmin | phpMyAdmin/ |
        | 80   | Hallo Welt!        | ~pi  |
        | 80   | PHP Version 7.     | ~pi/index.php  |
        | 8888 | Password:          |      |
        | 1880 | Raspberry Pi       |      |
        | 9001 | Neues Pad          |      |
        | 8181 | Server Status      |      |

# ToDo Port 9002 etherdraw; Jupyter login
