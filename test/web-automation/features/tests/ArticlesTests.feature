@ready
Feature: Login Accounts Tests

Background:
Given I am on My Blogspot HomePage

Scenario: Create a new article
  When I click link "Register" on the web page
  And I try to register using  "<username>" in name and "<email>" in email field
  And I click link "Login" on the web page
  And I login using "<valid>" credentials on the web page
  When I click link "Create New Article" on the web page
  And I create an article with title "Article Title" and description "Article description"
  Then The web page text should include "Article successfully created!"

  Scenario: Edit articles
    When I click link "Register" on the web page
    And I try to register using  "<username>" in name and "<email>" in email field
    And I click link "Login" on the web page
    And I login using "<valid>" credentials on the web page
    When I click link "Create New Article" on the web page
    And I create an article with title "Article Title" and description "Article description"
    When I click link "My Articles" on the web page
    When I click link "Edit Article" on the web page
    And I edit an article with title "Article Title2" and description "Article description2"
    Then The web page text should include "Article successfully updated!"

    Scenario: Delete articles
    When I click link "Register" on the web page
    And I try to register using  "<username>" in name and "<email>" in email field
    And I click link "Login" on the web page
    And I login using "<valid>" credentials on the web page
    When I click link "Create New Article" on the web page
    And I create an article with title "Article Title" and description "Article description"
    When I click link "My Articles" on the web page
    When I click link "Delete Article" on the web page
    Then The web page text should include "Article successfully deleted!"
