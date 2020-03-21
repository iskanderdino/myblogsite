@ready
Feature: Signup Business Create_Account
Background:
Given I am on My Blogspot HomePage

Scenario: Verify Register Page url
When I click "register" link on HomePage
Then I should be redirected to "register" page
# Scenario: Signup createAccount
# When I click "register" link on HomePage
# And I register a new account
# Then
