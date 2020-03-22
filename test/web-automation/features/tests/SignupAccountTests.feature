@ready
Feature: Signup Accounts Tests
Background:
Given I am on My Blogspot HomePage

Scenario: Verify Register Page url
When I click link "Register" on the web page
Then The web page url should include "signup"

Scenario: Error Messages for empty inputs in Registration form
When I click link "Register" on the web page
And I try to register using  "<empty>" in name and "<empty>" in email field
Then The web page text should include "Failed creating user!"
Then The web page text should include "Username can't be blank"
Then The web page text should include "Username is too short (minimum is 3 characters)"
Then The web page text should include "Email can't be blank"
Then The web page text should include "Email is invalid"

Scenario: Error Messages for invalid user inputs fields in Registration form
When I click link "Register" on the web page
And I try to register using  "<username>" in name and "<empty>" in email field
Then The web page text should include "Email can't be blank"
And The web page text should include "Email is invalid"
When I try to register using  "<username>" in name and "test.com" in email field
Then The web page text should include "Email is invalid"
When I try to register using  "<username>" in name and "test@yahoo" in email field
Then The web page text should include "Email is invalid"

Scenario: Error Messages for invalid email inputs fields in Registration form
When I click link "Register" on the web page
And I try to register using  "<empty>" in name and "<empty>" in email field
Then The web page text should include "Username can't be blank"
And The web page text should include "Username is too short (minimum is 3 characters)"
When I try to register using  "aa" in name and "test@yahoo" in email field
Then The web page text should include "Username is too short (minimum is 3 characters)"
When I try to register using  "asdfasdfasdfasdfsdfasfasfasfasfasfasfsfasfafafafafsfsf" in name and "test.com" in email field
Then The web page text should include "Username is too long (maximum is 25 characters)"

Scenario: Register an existing account
When I click link "Register" on the web page
And I try to register using  "<existing>" in name and "<existing>" in email field
Then The web page text should include "Username has already been taken"
Then The web page text should include "Email has already been taken"

Scenario: Successfully register account using valid credentials
When I click link "Register" on the web page
And I try to register using  "<username>" in name and "<email>" in email field
Then The web page text should include "Account successfully created!"
