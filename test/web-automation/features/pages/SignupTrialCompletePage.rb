class LoginPage
  include PageObject
  page_url "#{$portal_url}/login"

  def verify_url(url)
    ret = "https:\/\/www\.#{$DOMAIN}\/BusinessPortal/Signup\/TrialSignupComplete"
    puts "the value is #{ret}"
    ret.should == url
  end

end
