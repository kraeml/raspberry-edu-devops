Feature: Looking for websites on raspberry

  Scenario Outline: Checking all pages
    When I go on the page "http://localhost:<port>/<path>"
    Then see the content of "<content>"
      Examples:
        | port | content            | path |
        | 80   | PHP Version 7.0.19 |      |
        | 80   | Welcome to phpMyAdmin | phpMyAdmin/ |
        | 80   | Hallo Welt!        | ~pi  |
        | 80   | PHP Version 7.0.19 | ~pi/index.php  |
        | 8888 | Password:          |      |
        | 1880 | Node-RED Deploy info debug ctrl |      |
        | 9001 | New Pad or create/open a Pad |      |
        | 8181 | Server Status      |      |

# ToDo Port 9002 etherdraw; Jupyter login
