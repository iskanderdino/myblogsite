Given("I am on My Blogspot HomePage") do
  visit HomePage
end

Then("I should be redirected to {string} page") do |url|
  on RegisterPage do |page|
    page.verify_url(url)
  end
end

When("I try to register using  {string} in name and {string} in email field") do |user, email|
  on RegisterPage do |page|

    if user == "<existing>" && email == "<existing>"
      #generate user credentials
      $user_name = user = page.generate_user
      $user_email = email = page.generate_email

      page.register_user_with_credentials(user,email)

      existing_user = $user_name
      existing_email = $user_email

      step "I click link \"Register\" on the web page"
      #enter existing user credentials
      page.register_user_with_credentials(existing_user, existing_email)

    elsif user == "<username>" && email == "<email>"
      #generate user credentials
      $user_name = user = page.generate_user
      $user_email = email = page.generate_email
      page.register_user_with_credentials($user_name,$user_email)

    else
      $user_name = user
      $user_email = email

      puts "global existing user: #{$user_name}"
      puts "global existing email: #{$user_email}"

      page.register_user_with_credentials($user_name,$user_email)
    end
  end
end
