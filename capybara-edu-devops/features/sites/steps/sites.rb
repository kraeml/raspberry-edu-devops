When(/^I go on the page "([^"]*)"$/) do |arg1|
  visit arg1
end

Then(/^see the content of "([^"]*)"$/) do |arg1|
  expect(page).to have_content(arg1)
end

