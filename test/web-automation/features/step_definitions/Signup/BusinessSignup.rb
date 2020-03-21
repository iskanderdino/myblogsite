Given(/^I am on Livedrive Business Signup Page$/) do
  visit BusinessHomePage
end

When(/^I click "([^"]*)" link in the page$/) do |link|
  on BusinessHomePage do |page|
    page.click_link(link)
  end
end

Then(/^I should be redirected to business signup page$/) do
  on BusinessSignupPage do |page|
    page.verify_url(@browser.url)
  end
end

When(/^I signup account on Business Signup page$/) do
  on BusinessSignupPage do |page|
    page.signup_account
  end
end

Then(/^Account should successfully be created$/) do
  on SignupTrialCompletePage do |page|
    @browser.scroll.to :bottom
    page.verify_url(@browser.url)
  end
end
