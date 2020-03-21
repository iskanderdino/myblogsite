Before do
  browser = Watir::Browser.new :chrome
  @browser=browser
  @browser.driver.manage.window.maximize
end

After do
  @browser.close
end
