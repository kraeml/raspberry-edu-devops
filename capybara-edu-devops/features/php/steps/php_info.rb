Given(/^I am on "([^"]*)"$/) do |arg1|
  visit arg1
end

Then(/^content "([^"]*)" will seen$/) do |arg1|
  page.has_content?(arg1)
end
