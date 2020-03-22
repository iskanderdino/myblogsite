@ready
Feature: Signup Business Create_Account
Background:
Given I am on My Blogspot HomePage

# Scenario: Verify Register Page url
# When I click "register" link on HomePage
# Then I should be redirected to "register" page

Scenario: Error Messages for empty inputs in Registration form
When I click "register" link on HomePage
And I try to register using  "<empty>" in name and "<empty>" in email field
Then The web page text should include "Failed creating user!"
Then The web page text should include "Username can't be blank"
Then The web page text should include "Username is too short (minimum is 3 characters)"
Then The web page text should include "Email can't be blank"
Then The web page text should include "Email is invalid"

Scenario: Error Messages for invalid user inputs fields in Registration form
When I click "register" link on HomePage
And I try to register using  "<username>" in name and "<empty>" in email field
Then The web page text should include "Email can't be blank"
And The web page text should include "Email is invalid"
When I try to register using  "<username>" in name and "test.com" in email field
Then The web page text should include "Email is invalid"
When I try to register using  "<username>" in name and "test@yahoo" in email field
Then The web page text should include "Email is invalid"

Scenario: Error Messages for invalid email inputs fields in Registration form
When I click "register" link on HomePage
And I try to register using  "<empty>" in name and "<empty>" in email field
Then The web page text should include "Username can't be blank"
And The web page text should include "Username is too short (minimum is 3 characters)"
When I try to register using  "aa" in name and "test@yahoo" in email field
Then The web page text should include "Username is too short (minimum is 3 characters)"
When I try to register using  "asdfasdfasdfasdfsdfasfasfasfasfasfasfsfasfafafafafsfsf" in name and "test.com" in email field
Then The web page text should include "Username is too long (maximum is 25 characters)"

Scenario: Successfully register account using valid credentials
  When I click "register" link on HomePage
  And I try to register using  "<username>" in name and "<email>" in email field
  Then The web page text should include "Welcome to the My Blogsite"
