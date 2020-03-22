class LoginPage
  include PageObject
  page_url "#{$portal_url}/login"

  #initialize page objects
  text_field(:email, :id => "session_email")
  text_field(:password, :id => "session_password")
  button(:login, :value => "Log in")

  def login_account(email)
    if email == "<valid>"
      puts "user_email is: #{$user_email}"

      self.email = $user_email
      self.password = "testing123"
    else
      self.email = email
      self.password = "testing123"
    end
    self.login
  end

end
