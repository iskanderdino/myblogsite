class HomePage
  include PageObject

  page_url "#{$portal_url}"

  #initialize pageobjects
  link(:lnk_all_articles, :id => "all-articles")
  link(:lnk_login, :id => "login")
  link(:lnk_register, :id => "register")

  #define actions/methods to be used on page
  def verify_url(url)
    puts "the value is #{page_url}"
    page_url.should == url
  end

  def signup_account
    str=Time.now.to_s
    str.gsub!(/\+.*/,"")
    str.gsub!(/[-: ]/,"")
    username = "test_#{str}@yopmail.com"

    self.fname = "test"
    self.lname = "test"
    self.cname = "biztest"
    self.emailuser = username
    self.password = "Testing123"
    self.createAccount
  end

  def click_link(link)
    if link == "register"
      self.lnk_register
    end
  end

end
