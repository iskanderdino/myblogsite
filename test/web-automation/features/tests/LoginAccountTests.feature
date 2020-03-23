@ready
Feature: Login Accounts Tests

Background:
Given I am on My Blogspot HomePage

Scenario: Verify Register Page url
When I click link "Login" on the web page
Then The web page url should include "login"

Scenario: Login using valid credentials
When I click link "Register" on the web page
And I try to register using  "<username>" in name and "<email>" in email field
And I click link "Login" on the web page
And I login using "<valid>" credentials on the web page
Then The web page text should include "Welcome back"
