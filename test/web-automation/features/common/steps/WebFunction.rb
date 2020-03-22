When(/^I click link "([^"]*)" on the web page$/) do |link_text|
    @browser.link(:text =>link_text).click
    wait_until_the_page_loads
end

# When(/^I click link with id "([^"]*)" on the web page$/) do |link_id|
#   @browser.link(:id =>link_id).click
#   wait_until_the_page_loads
# end
#
# When(/^I click button with id "([^"]*)" on the web page$/) do |button_id|
#   @browser.button(:id =>button_id).click
#   wait_until_the_page_loads
# end
#
# When(/^I click radio button with id "([^"]*)" on the web page$/) do |radiobutton_id|
#    @browser.radio(:id =>radiobutton_id).click
#    wait_until_the_page_loads
# end
#
# When(/^I click checkbox with attribute "([^"]*)" and value "([^"]*)" on the web page$/) do |element_attribute,element_value|
#    @browser.checkbox(:"#{element_attribute}" => element_value).click
#    wait_until_the_page_loads
# end
#
# When(/^I click element Label with attribute "([^"]*)" and value "([^"]*)" on the web page$/) do |element_attribute, element_value|
#    @browser.label(:"#{element_attribute}" => /#{element_value}/).click
#    wait_until_the_page_loads
# end
#
# #will fix failing test on element not being seen when being scrolled to
# When(/^I scroll down to the link with attribute "([^"]*)" and value "([^"]*)" on the web page$/) do |element_attribute, element_value|
#   coords = @browser.link(:"#{element_attribute}" => element_value).wd.location
#   coords1 = coords[0].to_i
#   coords2 = coords[1].to_i - 300
#   @browser.scroll.to [coords1, coords2]
# end
#
# When(/^I click link with attribute "([^"]*)" and value "([^"]*)" on the web page$/) do |element_attribute, element_value|
#   wait_until_the_page_loads
#   element_value.gsub! "$user_email", "#{$user_email}"
#   @browser.link(:"#{element_attribute}" => element_value).click
#   wait_until_the_page_loads
# end
#
# When(/^I click button with attribute "([^"]*)" and value "([^"]*)" on the web page$/) do |element_attribute, element_value|
#   @browser.button(:"#{element_attribute}" => element_value).click
#   wait_until_the_page_loads
# end
#
# When(/^I click radio button with attribute "([^"]*)" and value "([^"]*)" on the web page$/) do |element_attribute, element_value|
#   @browser.radio(:"#{element_attribute}" => element_value).click
#   wait_until_the_page_loads
# end
#
# When(/^I click the label "([^"]*)" on the web page$/) do |label_text|
#   @browser.label(:text =>label_text).click
#   wait_until_the_page_loads
# end

Then(/^The web page text should include "([^"]*)"$/) do |msg|
  wait_until_the_page_loads
  if msg.match(/<today+(.*)>/)
    days=msg.match(/<today\+(.*)>/)[1]
    msg=add_days_to_today(days,"%d/%m/%Y")
  end
  msg=extract_function_call_from_text_and_execute(msg)
  msg.gsub! "$VAT", "#{$VAT}"
  msg.gsub! "$user_email", "#{$user_email}"
  if msg.include?('<firstname>')
    msg.gsub! "<firstname>", "#{get_account_firstname($user_email)}"
  end
  if msg != '<do not check>' then
      msg=msg.gsub("dblquotes","\"")
      wait_until_page_text_contains(msg)
      @browser.text.should include(msg)
  end
end

# Then(/^The web page contents should include "([^"]*)"$/) do |msg|
#   arrstring = msg.split(/(?<!\\),/).map!(&:strip)
#   arrstring.each {|arrmsg|
#       arrmsg = arrmsg.gsub('\,',',')
#       step "The web page text should include \"#{arrmsg}\""
#   }
# end
#
# Then(/^The web page text should not include "([^"]*)"$/) do |msg|
#   wait_until_the_page_loads
#   if msg.include?('<firstname>')
#     msg.gsub! "<firstname>", "#{get_account_firstname($user_email)}"
#   end
#     if msg != '<do not check>' then
#       @browser.text.include?(msg).should == false
#   end
# end

Then(/^The web page url should include "([^"]*)"$/) do |list_of_strings|
  wait_until_the_page_loads
    list_of_strings.split(",").each do |string|
        @browser.windows.last.use
        @browser.url.should include(string)
    end
end

# Then(/^The web page url should not include "([^"]*)"$/) do |list_of_strings|
#   wait_until_the_page_loads
#     list_of_strings.split(",").each do |string|
#         @browser.url.include?(string).should_not == true
#     end
# end
#
# And(/^I should see text "([^"]*)" in text field with id "([^"]*)" on the web page$/) do |text, textfield_id|
#   wait_until_the_page_loads
#   if text == "PI_email"
#     text=$PI_email
#   end
#   @browser.text_field(:id => textfield_id).value.include?(text).should == true
# end
#
# Then(/^I should see text "([^"]*)" with attribute "([^"]*)" and value "([^"]*)" on the web page$/) do |msg, element_attribute, element_value|
#   wait_until_the_page_loads
#   if msg == "Briefcase"
#     msg = $BRIEFCASE
#   end
#   thiselement =
#   if @browser.element(:"#{element_attribute}" => "#{element_value}").text  == msg.upcase
#     @browser.element(:"#{element_attribute}" => "#{element_value}").text.should include(msg.upcase)
#   else
#     @browser.element(:"#{element_attribute}" => "#{element_value}").text.should include(msg.capitalize)
#   end
# end
#
# Then(/^The button with text "([^"]*)" "([^"]*)" be active$/) do |value,should_shouldnot|
#     exp=should_shouldnot.downcase == "should" ? true : false
#     @browser.button(:value => value).enabled?.should == exp
# end
#
# Given(/^I visit "(.*)" link for "(.*)" page$/) do |url, not_used|
#   @browser.goto(url)
#   wait_until_the_page_loads
# end
#
# Given(/^I visit unsubscribe page for user "([^"]*)"$/) do |email|
#   if email == "NA"
#     email = $user_email = get_random_email
#   elsif email == "RES"
#     email = $reseller_email
#   elsif email == "USED_NA"
#     email = $user_email
#   end
#   str=$DOMAIN+"/unsubscribe?key="+encode_to_base64(email)
#   @browser.goto(str)
#   wait_until_the_page_loads
# end
#
# Then(/^The web page with url including "([^"]*)" should open in a new tab$/) do |url_text|
#   wait_until_second_tab_loads
#   @browser.windows.last.use
#   @browser.windows.count == 2
#   @browser.url.include?(url_text).should == true
#   @browser.windows.last.close
#   wait_until_the_page_loads
# end
#
# Then(/^The url for "([^"]*)" link should include "([^"]*)"$/) do |link_text, link_url_text|
#   @browser.link(:text => link_text).href.include?(link_url_text).should == true
# end
#
# Then(/^The href for link with title "([^"]*)" should include "([^"]*)"$/) do |link_text, link_url_text|
#   @browser.link(:title => link_text).href.include?(link_url_text).should == true
# end
#
# When(/^I visit the current web page with http$/) do
#   page_url=@browser.url
#   page_url.gsub!(/https/,"http")
#   @browser.goto(page_url)
#   wait_until_the_page_loads
# end
# Then(/^The page should show correct title "(.*?)"$/) do |text|
#   wait_until_the_page_loads
#   @browser.title.should == text
# end
# When(/^I scroll down to the end of the page$/) do
#   wait_until_the_page_loads
#   @browser.scroll.to :bottom
# end
#
# When(/^I scroll the page to coordinates "([^"]*)" and "([^"]*)"$/) do |xcoord, ycoord|
#   @browser.scroll.to [xcoord, ycoord]
# end

Given(/^I take a break for "([^"]*)" seconds$/) do |timeout|
  sleep(timeout.to_i)
end
#
# And(/^I refresh the web page$/) do
#   @browser.refresh
#   wait_until_the_page_loads
# end
#
# Then(/^The Billing iframe error messages should include "([^"]*)"$/) do |msg|
# 	on ConsumerUpdateBillingDetails do |page|
# 		arrstring = msg.split(',').map!(&:strip)
# 		arrstring.each do |arrmsg|
# 			page.get_error_msg_list.should include(arrmsg)
# 		end
# 	end
# end
#
# When(/^I click Span with title "([^"]*)"$/) do |span_title|
#   @browser.span(:title => span_title).click
#   wait_until_the_page_loads
# end
#
#
# When(/^I replace "([^"]*)" with "([^"]*)" in the browser url$/) do |old_url, new_url|
#     @browser.goto(@browser.url.gsub!("/#{old_url}", "/#{new_url}"))
#     wait_until_the_page_loads
# end
#
# Then(/^I click span with text "([^"]*)" on the web page$/) do |span_text|
#   @browser.span(:text => span_text).click
#   wait_until_the_page_loads
# end
#
# When(/^I click span with attribute "([^"]*)" and value "([^"]*)" on the web page$/) do |element_attribute, element_value|
#   @browser.span(:"#{element_attribute}" => element_value).click
#   wait_until_the_page_loads
# end
#
#
# Then(/^The link with text "([^"]*)" "(should|should not)" be shown on the webpage$/) do |value,condition|
#     wait_until_the_page_loads
#     exp=condition.downcase == "should" ? true : false
#     @browser.link(:text => value).exists?.should == exp
# end
#
# When (/^I return to the previous page$/) do
#     @browser.back
#
#     # this conditional statement will fix issue in TKHTermsAndConditionPage.feature
#     # where instead of going back to a blank previous page will instead return the user to the current page
#     if @browser.url.include?("data:")
#       @browser.forward
#     end
# end
#
# Given(/^I start typing "([^"]*)" in the textbox with attibute "([^"]*)" and value "([^"]*)" on the page$/) do |text, element_attribute, element_value|
#   @browser.text_field(:"#{element_attribute}" => element_value).clear
#   @browser.text_field(:"#{element_attribute}" => element_value).set(text)
# end
#
# Then(/^The cookie name "([^"]*)" with attribute "([^"]*)" "(should|should not)" show "([^"]*)"$/) do |cookie_name, cookie_attribute, res, cookie_value|
# 	exp = res.downcase == "should" ? true : false
# 	cookie_n = @browser.cookies[cookie_name.to_sym]
# 	cookie_a = cookie_n[cookie_attribute.to_sym]
# 		if cookie_value.match(/<today\+(.*)month>/)
# 			months = cookie_value.match(/<today\+(.*)month>/)[1]
# 			cookie_value = add_month_to_today(months, "%Y-%m-%d")
# 		end
# 	cookie_a.to_s.include?(cookie_value.to_s).should == exp
# end
#
# And("I read the ASP.NET sessionId from browser cookie and store it in $session_id") do
#   $session_id = @browser.cookies["ASP.NET_SessionId".to_sym]["value".to_sym]
# end
#
# And("I read the {string} cookie from browser and store it in $cookie") do |name|
#   cookie_value = @browser.cookies[name.to_sym]["value".to_sym]
#   $cookie = "#{name}=#{cookie_value}"
# end
#
# When(/^I close current browser tab$/) do
#   @browser.windows.last.close
#   @browser.windows.last.use
# end
#
# When("I change the value of cookie name {string} to {string}") do |cookie_name, cookie_value|
#   @browser.cookies.add "#{cookie_name}", "#{cookie_value}"
#   wait_until_the_page_loads
# end
