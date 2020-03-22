Given("I am on My Blogspot HomePage") do
  visit HomePage
end


When("I click {string} link on HomePage") do |link|
  on HomePage do |page|
    page.click_link(link)
  end
end

Then("I should be redirected to {string} page") do |url|
  on RegisterPage do |page|
    page.verify_url(url)
  end
end

When("I try to register using  {string} in name and {string} in email field") do |user, email|
  on RegisterPage do |page|
    page.register_user_with_credentials(user,email)
  end
end
