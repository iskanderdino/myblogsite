class RegisterPage
  include PageObject


  #initialize pageobjects
  link(:lnksignup, :xpath => "//*[@id='LoginBusiness']/a[2]")
  text_field(:username, :id => "username")
  text_field(:email, :id => "email")
  text_field(:password, :id => "password")

  button(:save, :value => "Sign-up")
  link(:back, :id => "back")

  #define actions/methods to be used on page

  def register_account
    str=Time.now.to_s
    str.gsub!(/\+.*/,"")
    str.gsub!(/[-: ]/,"")
    username = "test_#{str}@yopmail.com"

    self.email = username;
    self.password = "testing123"
    self.save
  end

  def verify_url(url)
    page_url = "#{$portal_url}/register"
    puts "the value is #{page_url}"
    page_url.include?(url)
  end

end
