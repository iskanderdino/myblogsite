def wait_until_page_text_contains_either(str1, str2)
  sleep(1)
  cnt=1
  while !(@browser.text.include? str1 or @browser.text.include? str2)
    cnt=cnt+1
    if cnt >= 50
    puts "Waited for some time, text did not show #{str1}, #{str2}"
    break
  end
  sleep(1)
  end
end

def wait_until_second_tab_loads()
    sleep(1)
    cnt=1
    while @browser.windows.count != 2
        cnt=cnt+1
        if cnt >= 50
            puts "Waited for some time, new tab not found"
            break
        end
        sleep(1)
    end
end

def wait_until_at_least_one_file_is_loaded_in_bc()
  sleep(1)
  cnt=1
  while !(@browser.divs(:id => /node_.*/).count > 0)
    cnt=cnt+1
    if cnt >= 50
        puts "Waited for some time, did not load the nodes"
        break
    end
    sleep(1)
  end
end


def wait_until_page_text_contains(str)
    sleep(1)
    cnt=1
    while !(@browser.text.include? str)
        cnt=cnt+1
        if cnt >= 50
            puts "Waited for some time, page did not show #{str}"
            break
        end
        sleep(1)
    end
end

def wait_until_url_contains(str)
    sleep(1)
    cnt=1
    while !(@browser.url.include? str)
        cnt=cnt+1
        if cnt >= 50
            puts "Waited for some time, url did not show #{str}"
            break
        end
        sleep(1)
    end
end

def wait_until_the_page_loads
       sleep(1)
       cnt=1
       while !(@browser.text.match(/[a-zA-Z]+/))
               puts "in"
               cnt=cnt+1
               if cnt >= 50
                       puts "Waited for some time,looks like page did not load. No text seen on the page"
                       break
               end
               sleep(1)
       end
end
def encode_to_base64(str)
  return Base64.encode64(str)
end

def verify_portal_message(msg)
    @browser.div(:class => /notification.*/).text.include?(msg).should == true # used regEx as the class names are different on cloudev and myknowhowcloud
end

def verify_portal_error(errmsg)
    @browser.div(:id => "StatusMessage").text.include?(msg).should == true
end

def extract_subdomain
	if @browser.url.include?("portal")
		if @browser.url =~ /https:\/\/(.*)\.#{$DOMAIN}\/.*/
			return $~[1]
		else
			puts "no subdomain found. Make sure user logged in."
		end
	else
		puts "User not logged in"
	end
end


def wait_until_element_exists_on_page(ele, att, val)
 	sleep(1)
	cnt=1
	while !(verify_element_exists_on_page(ele, att, val))
		cnt=cnt+1
		if cnt >= 50
			puts "Waited for some time, verify_element_exists_on_page did not return true"
			break
		end
		sleep(1)
	end
end

def verify_element_exists_on_page(ele, att, val)
	ele = ele.downcase
    if ele == "link"
        return @browser.link(:"#{att}", val).exists?
    elsif ele == "div"
        return @browser.div(:"#{att}", val).exists?
    elsif ele == "strong"
        return @browser.strong(:"#{att}", val).exists?
    elsif ele == "h2"
        return @browser.h2(:"#{att}", val).exists?
    elsif ele == "h3"
        return @browser.h3(:"#{att}", val).exists?
    end
    return false
 end


CHARS = ('a'..'z').to_a
def rand_string(length)
  s=''
  length.times{ s << CHARS[rand(CHARS.length)] }
  return s
end

HEX_CHARS = (('0'..'9').to_a + ('a'..'f').to_a).to_a
def rand_hex_string(length)
  s=''
  length.times{ s << HEX_CHARS[rand(HEX_CHARS.length)] }
  return s
end

def fix_guid(uniqueid)
  if uniqueid != '' and uniqueid.length == 32
    return uniqueid[6..7] + uniqueid[4..5] + uniqueid[2..3] + uniqueid[0..1] + uniqueid[10..11] + uniqueid[8..9] + uniqueid[14..15] + uniqueid[12..13] + uniqueid[16..-1]
  else
    return uniqueid
  end
end

def add_year_to_today(years)
    t=Date.today >> years.to_i * 12
    return t.strftime("%Y")
end

def add_month_to_today(months, format)
    t=Date.today >> months.to_i
    return t.strftime(format)
end

def add_days_to_today(days, format)
  days_to_add=days
  if days.include?("eval")
    cmd=days.match('eval\((.*)\)')[1]
    days_to_add=eval(cmd.gsub('date','Date'))
    #Some times for DB verification, the input table is converted to lowercase i.e Date.today becomes date.today, which fails
  end
  t=Date.today.next_day(days_to_add.to_i)
  return t.strftime(format)
end

#
# Adapted by Paul Marclay, paul.eduardo.marclay@gmail.com
#
#VISA_PREFIX_LIST = ["4539", "4556", "4916", "4532", "4929", "40240071", "4485", "4716", "4"]
#MASTERCARD_PREFIX_LIST = ["51","52","53","54","55"]
#AMEX_PREFIX_LIST = ["34", "37"]
#DISCOVERY_PREFIX_LIST = ["6011"]
#DINERS_PREFIX_LIST = ["300", "301", "302", "303", "36", "38"]
#ENROUTE_PREFIX_LIST = ["2014", "2149"]
#JBC_PREFIX_LIST = ["35"]
#VOYAGER_PREFIX_LIST = ["8699"]
def completed_number(prefix, length)
    cc_number = prefix
    # generate digits
    1...(length - (prefix.length + 1)).times do
        cc_number += "#{rand(9)}"
    end
    # Calculate sum
    sum, pos = 0, 0
    reversed_cc_number = cc_number.reverse
    while pos < length do
        odd = reversed_cc_number[pos].to_i * 2
        odd -= 9 if odd > 9
        sum += odd
        sum += reversed_cc_number[pos + 1].to_i if pos != (length - 2)
        pos += 2;
    end
    # Calculate check digit
    checkdigit = (((sum / 10).floor + 1) * 10 - sum) % 10
    cc_number += checkdigit.to_s;
    return cc_number
end

def get_random_email
    str=Time.now.to_s
    str.gsub!(/\+.*/,"")
    str.gsub!(/[-: ]/,"")
    username = "test_#{str}@livedrive.com"
    return username
end
def click_i_agree_terms
  @browser.checkbox(:id => "chkBoxAgree", :value => "agreed").click
end

def click_i_agree_terms_TKH
  @browser.scroll.to :bottom
  @browser.label(:text => "I agree to the Terms & Conditions above*").click
end

def get_brand(domain)
    if domain.include?("livedrive")
      return "livedrive"
    elsif domain.include?("knowhow")
      return "knowhow"
    elsif domain.include?("geeksquad")
      return "geeksquad"
    end
end
def wait_until_thumbnail_loads(img)
      cnt=1
      while (img.src == "")
        cnt=cnt+1
        if cnt >= 5
            puts "Waited for some time, thumbnail did not load for #{img}"
            break
        end
        sleep(1)
      end
end
def compare_hashes(db_values, input_values)
  #Convert the db output, key and values into lowercase
  db_values_lowercase = Array.new
  db_values.each do |db|
    a=Hash.new
    db.each do |k,v|
      a[k.downcase.to_s]=v.to_s.downcase
    end
    db_values_lowercase.push(a)
  end
  #Convert the input table, key and values into lowercase
  input_values_lowercase = Array.new
  input_values.each do |ip|
    a=Hash.new
    ip.each do |k,v|
      if v.include?("$api_response") or v.include?("<find_")
        a[k.downcase.to_s]=v.to_s
      else
        a[k.downcase.to_s]=v.to_s.downcase
      end
    end
    input_values_lowercase.push(a)
  end
  #iterate through the array of hashes and compare
  for i in (0 .. input_values_lowercase.length-1)
    #Interate through all keys
    input_values_lowercase[i].keys.each do |k|
      puts "Checking column #{k}"
      if input_values_lowercase[i][k].include?("today")
        days=input_values_lowercase[i][k].match(/today\+?(.*)/)[1]
        input_values_lowercase[i][k] = add_days_to_today(days,'%Y-%m-%d')
      end
      input_values_lowercase[i][k]=extract_function_call_from_text_and_execute(input_values_lowercase[i][k])
      if input_values_lowercase[i][k].include?("currentmonth")
        months=input_values_lowercase[i][k].match(/currentmonth\+?(.*)/)[1]
        input_values_lowercase[i][k] = add_month_to_today(months,'%Y-%m-%d')
      end
  #if the exp results is XXX<$api_response....>XXXX, then replace it with actual response. Other wise, multiply by 100 (usually for verifying the prices)
      if input_values_lowercase[i][k].include?("\$api_response")
        if input_values_lowercase[i][k].include?("<\$api_response")
          path=input_values_lowercase[i][k].match(/<\$api_response=>(.*)>/)[1]
          temp=input_values_lowercase[i][k]
          input_values_lowercase[i][k]=temp.sub(/<\$api_response=>(.*)>/,get_value_for_a_key_from_response(path).to_s)
          input_values_lowercase[i][k]=input_values_lowercase[i][k].downcase
        else
          path=input_values_lowercase[i][k].match(/\$api_response=>(.*)/)[1]
          #The divisor is always 100
          input_values_lowercase[i][k]=(get_value_for_a_key_from_response(path)*100).to_i.to_s
        end
      end
      if input_values_lowercase[i][k].include?("<accountid")
        user=input_values_lowercase[i][k].match(/<accountid_(.*)/)[1]
        if user == "NA"
          id=get_account_id($user_email)
        else
          user == "BIZ"
          id=get_account_id($business_email)
        end
        input_values_lowercase[i][k] = id.to_s
      end
      #This one was added for Notes column if the expected result included find_* functions.
      input_values_lowercase_lowercase = Array.new
      input_values_lowercase.each do |ip|
        a=Hash.new
        ip.each do |k,v|
            a[k.downcase.to_s]=v.to_s.downcase
        end
        input_values_lowercase_lowercase.push(a)
      end

      if input_values_lowercase_lowercase[i][k] == "".to_s
        db_values_lowercase[i][k].to_s.empty?.should == true
      else
        if ["duedate", "issuedate", "lastpaid", "added", "datepaid", "startdate", "enddate", "createddate", "datecreated", "closuredate", "sent", "archive_date"].include?(k)
          db_values_lowercase[i][k].should include(input_values_lowercase_lowercase[i][k])
        else
          db_values_lowercase[i][k].should == input_values_lowercase_lowercase[i][k]
        end
      end
    end
  end
end
def call_webservice_ajaxhandler_method(user, brand_domain, request, cookie)
  if user == "NA"
    user=$user_email
  elsif user == "BIZ"
    user=$business_email
  end
  subdomain=get_subdomain(user)
  if cookie.match(/ASP.NET_SessionId=/) == nil
    cookie="ASP.NET_SessionId="+cookie
  end

  conn = Faraday.new(:url => "https://#{subdomain}.#{brand_domain}/webservice/AjaxHandler.ashx") do |faraday|
    faraday.request  :url_encoded             # form-encode POST params
    faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
  end
  res = $api_response = conn.get do |req|
    req.url "#{request}"
    req.headers['Content-Type'] = 'application/json'
    req.headers['Accept'] = 'application/hal+json'
    req.headers['cookie'] = cookie
  end
  return res
end

def find_discount_value(user, discount_type, productname_from_xml, account_aged = 0)
  if user == "NA"
    user=$user_email
  elsif user == "BIZ"
    user=$business_email
  else
    user=user
  end

  product=DataMagic.load('ProductServiceProducts.yml')
  product_details=product[productname_from_xml]
  months=product_details['Subscription']
  renewal_date=get_renewal_date_from_db(user)

  case discount_type
  when "DaysRemaining"
    subscription_days=((Date.parse(renewal_date.to_s)) -  (Date.parse(renewal_date.to_s) << (1*months)))
    discount_days=subscription_days-account_aged
  when "TrialDaysRemaining"
    discount_days=product_details['Trial_days']-account_aged
  when "ExtendedTrial"
    trial_days=product_details['Trial_days']-account_aged
    discount_days=((Date.today + trial_days) >> 1*months) - (Date.today + trial_days) + trial_days
  else
    puts "Incorrect #{discount_type}"
  end
  puts "find_discount_value: discount_days: #{discount_days}"
  return discount_days.to_i
end
def find_discount_amount(user, discount_type, productname_from_xml, product_key, account_aged = 0)
  if productname_from_xml.split(/,/).length == 2
    product=productname_from_xml.split(/,/)[0]
    product_to_find_daily_price=productname_from_xml.split(/,/)[1]
  else
    product_to_find_daily_price=product=productname_from_xml.split(/,/)[0]
  end
  total_discount=0
  discount_type.split(/,/).each do |each_discount_type|
    price_of_a_day=find_price_of_one_day(user, each_discount_type, product_to_find_daily_price, product_key)
    discount_days=find_discount_value(user, each_discount_type, product, account_aged)
    total_discount=total_discount+(discount_days*price_of_a_day)
  end
  puts "find_discount_amount: discount_value: #{total_discount}"
  return total_discount.round(2)
end
def find_initial_price(user, discount_type, productname_from_xml, product_key, account_aged = 0)
  if user == "NA"
    user=$user_email
  elsif user == "BIZ"
    user=$business_email
  else
    user=user
  end
  product=DataMagic.load('ProductServiceProducts.yml')
  upgrade_product_price=product[productname_from_xml][product_key]
  discount=find_discount_amount(user, discount_type, productname_from_xml, product_key, account_aged)
  price = upgrade_product_price.to_f-discount.to_f
  return price.round(2)
end
def find_next_recurdate(productname_from_xml, in_trial, extend_by_trial_period, format, account_aged = 0)
  product=DataMagic.load('ProductServiceProducts.yml')
  month=product[productname_from_xml]['Subscription']
  trial_days=product[productname_from_xml]['Trial_days']
  if extend_by_trial_period.to_s.downcase == "false"
    if in_trial.to_s.downcase == "true"
      days=(((Date.today + trial_days) - (Date.today)) - account_aged).to_i
    else
      days=(((Date.today >> 1*month) - (Date.today)) - account_aged).to_i
    end
  else
  #For CRM extension and end trial. The recurring date is today+14+subscription_length
   days=((((Date.today + trial_days) >> 1*month) - (Date.today + trial_days) + trial_days) - account_aged).to_i
  end
  puts "find_next_recurdate: days: #{days}"
  return add_days_to_today(days.to_s, format).to_s
end

def find_price_of_one_day(user, discount_type, product, product_key)
  if user == "NA"
    user=$user_email
  elsif user == "BIZ"
    user=$business_email
  else
    user=user
  end
  product_details=DataMagic.load('ProductServiceProducts.yml')[product]
  months=product_details['Subscription']
  contract_start_date=get_contract_start_date(user)
  renewal_date=get_renewal_date_from_db(user)

  case discount_type
  when "DaysRemaining"
    subscription_days=((Date.parse(renewal_date.to_s)) -  (Date.parse(renewal_date.to_s) << (1*months)))
  when "TrialDaysRemaining"
    subscription_days=((Date.parse(contract_start_date.to_s) >> (1*months)) -  (Date.parse(contract_start_date.to_s)))
  when "ExtendedTrial"
    subscription_days=(Date.today >> 1*months) - Date.today
  else
    puts "Error"
  end
  puts "Subscription_days: #{subscription_days}"
  if product_key == "Upgrade1_Price"
    price_of_a_day=(product_details['Recur_Price'].to_f/subscription_days.to_f)
  elsif product_key == "User_Price"
    price_of_a_day=(product_details[product_key].to_f/subscription_days.to_f)
  end
  puts "price_of_a_day: #{price_of_a_day}"
  return price_of_a_day
end

def extract_function_call_from_text_and_execute(msg)
  if msg.match(/<find_next_recurdate\((.*)\)>/) or msg.match(/<find_discount_value\(.*\)>/) or msg.match(/<find_discount_amount\(.*\)>/) or msg.match(/<find_initial_price\(.*\)>/)
    functionname=msg.match(/<(.*)\((.*)\)>/)[1].to_s
    a=msg.match(/<(.*)\((.*)\)>/)[2]
    functioncall=functionname+"("
    arguments=a.split(/,/)
    for i in 0..arguments.length-2 do
      functioncall=functioncall+arguments[i]+","
    end
    functioncall=functioncall+arguments[arguments.length-1]+")"
    new_msg=eval(functioncall)
    msg.gsub! /<find.*>/, new_msg.to_s
  end
  return msg
end
