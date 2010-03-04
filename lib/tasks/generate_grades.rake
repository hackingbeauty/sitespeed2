require "hpricot"

namespace :grades do
  
  desc "Generate Yslow! and Page Speed Grades"
  task :generate => [:alexa, :yslow, :pagespeed]

  desc "Generate Top 100 Alexa Rankings"
  task :alexa => :environment do
    print "Generating Top 100 Alexa Rankings"
    
    access_key_id = "1BGAEKAN2EQKHCG8HS82"
    secret_access_key = "p5yNDaEaNOJIr1ijh14/LP7E6qGfrx37ODWrMnr/"
    action = "TopSites"
    responseGroup = "Country"
    country = "US"  
    start = 1
    count = 100
    timestamp = ( Time::now ).utc.strftime("%Y-%m-%dT%H:%M:%S.000Z")
    signature = Base64.encode64( OpenSSL::HMAC.digest( OpenSSL::Digest::Digest.new( "sha1" ), secret_access_key, action + timestamp)).strip
    url = URI.parse(

              "http://ats.amazonaws.com?" +
              {
                "Action"       => action,
                "AWSAccessKeyId"  => access_key_id,
                "Signature"       => signature,
                "Timestamp"       => timestamp,
                "ResponseGroup"   => responseGroup,
                "Start"   	      => start,
                "Count"           => count,
                "CountryCode"     => country 
              }.to_a.collect{|item| item.first + "=" + CGI::escape(item.last.to_s) }.join("&")     # Put key value pairs into http GET format
           )
    xml = Hpricot.parse(Net::HTTP.get(url))
    File.open('alexa_top_100.csv', 'w'){ |f|
      (xml/'aws:sites'/'aws:site').each do |site|
        site
        url = (site/'aws:dataurl').inner_html
        country_rank = (site/'aws:country'/'aws:rank').inner_html
        global_rank = (site/'aws:global'/'aws:rank').inner_html
        country_reach_permillion = (site/'aws:country'/'aws:reach'/'aws:permillion').inner_html
        country_pageviews_permillion = (site/'aws:country'/'aws:pageviews'/'aws:permillion').inner_html
        country_pageviews_peruser = (site/'aws:country'/'aws:pageviews'/'aws:peruser').inner_html
        puts url + " - " + 
            country_rank + "(cr) - " + 
            global_rank + "(gr) - " + 
            country_reach_permillion + "(crpm) - " +  
            country_pageviews_permillion + "(cppm) - " + 
            country_pageviews_peruser + "(cppu) - " 
        f.write url + "," + 
                country_rank + "," + 
                global_rank + "," + 
                country_reach_permillion + "," +  
                country_pageviews_permillion + "," + 
                country_pageviews_peruser + "\n"
      end
    }

    puts "\nDone!"
  end
  
  desc "Generate Yslow! Grades"
  task :yslow => :environment do
    print "Generating Yslow! Grades for"
    File.open('alexa_top_100.csv','r+').each_line("\n") do |row|
      columns = row.split(",")
      url = columns[0]
      u = Url.find_or_create_by_url(u)
      u.url = columns[0]
      u.country = "US"
      u.country_rank = columns[1]
      u.global_rank = columns[2]
      u.country_reach_permillion = columns[3]
      u.country_page_views_permillion = columns[4]
      u.country_page_views_peruser = columns[5]
      u.save
      # @firefox = %x[firefox-bin -p YSLOW #{url}]
      exec "firefox-bin -p YSLOW #{url}"
      exec "killall firefox-bin"
      # exec "sleep 30"
      # exec "killall firefox-bin"
      # exec "sleep 10"
      # %x[firefox-bin -p YSLOW #{url}]
      # %x[sleep 30]
      # %[killall firefox-bin]
      # %x[sleep 10]
      puts url
    end
    puts "\nDone"
  end
  
  desc  'Generate Page Speed Grades'
  task :pagespeed => :environment do
    print "Generating Page Speed Grades"
    puts "\nDone"
  end
  
end
