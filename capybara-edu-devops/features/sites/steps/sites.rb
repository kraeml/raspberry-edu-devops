When(/^I go on the page "([^"]*)"$/) do |arg1|
  visit arg1
end

Then(/^see the content of "([^"]*)"$/) do |arg1|
  page.has_content?(arg1)
end

