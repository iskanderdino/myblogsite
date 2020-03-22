class RegisterPage
  include PageObject
  page_url "#{$portal_url}/register"

  #initialize pageobjects
  link(:lnksignup, :xpath => "//*[@id='LoginBusiness']/a[2]")
  text_field(:username, :id => "username")
  text_field(:email, :id => "email")
  text_field(:password, :id => "password")

  button(:save, :value => "Sign-up")
  link(:back, :id => "back")

  #define actions/methods to be used on page
  def verify_url(url)
    page_url = "#{$portal_url}/register"
    puts "the value is #{page_url}"
    page_url.include?(url)
  end

  def generate_user
    str=Time.now.to_s
    str.gsub!(/\+.*/,"")
    str.gsub!(/[-: ]/,"")
    username = "user#{str}"
  end

  def generate_email
    str=Time.now.to_s
    str.gsub!(/\+.*/,"")
    str.gsub!(/[-: ]/,"")
    email = "test_#{str}@yopmail.com"
  end

  def register_account
    username = generate_email
    email = generate_email
    self.username = username
    self.email = username;
    self.password = "testing123"
    self.save
  end

  def register_user_with_credentials(user, mail)
    if user == "<empty>"
      self.username = ""
    elsif user == "<username>"
      puts "username: #{username}"
      self.username = generate_user
    else
      self.username = user
    end

    if mail == "<empty>"
      self.email = ""
    elsif mail == "<email>"
      puts "email: #{email}"
      self.email = generate_email
    else
      self.email = mail
    end

    self.password = "testing123"

    self.save
  end

end
