require 'hpricot'
require 'firewatir'

namespace :grades do
  
  csv_file = RAILS_ROOT + '/tmp/alexa_top_100.csv'
  
  desc "Generate Yslow! and Page Speed Grades"
  task :generate => [:alexa, :yslow, :pagespeed]

  desc "Generate Top 100 Alexa Rankings"
  task :alexa => :environment do
    print "Generating Top 100 Alexa Rankings \n"
    
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
 
    File.open(csv_file, 'w'){ |f|
      (xml/'aws:sites'/'aws:site').each do |site|
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
    }# end File.open
        
    puts "\nDone!"
  
  end
  
  desc "Insert Alexa Grades Into Database"
  task :insert => :environment do
    File.open(csv_file,'r+').each_line("\n") do |row|
      columns = row.split(",")
      url = columns[0]
      # total_url = "http://www.#{url.to_s}/"
      total_url = url.to_s
      u = Url.find_or_create_by_url_name(total_url)
      u.url_name = total_url
      u.country = "US"
      u.country_rank = columns[1]
      u.global_rank = columns[2]
      u.country_reach_permillion = columns[3]
      u.country_page_views_permillion = columns[4]
      u.country_page_views_peruser = columns[5]
      u.save
      
      puts "\n url is #{total_url}"
    end
    
  end
  
  # To execute rake task and pass arguments type the following => rake grades:yslow[20,100]
  desc "Generate Yslow! Grades"
  task :yslow, :start_url, :end_url do |t, args|
    print "Generating Yslow! Grades \n"
    
    if :start_url == nil || :end_url == nil
      return "Please enter a start and end number"
      Kernet.exit
    end
    
    puts "args are #{args}"
    
    url_start = args[:start_url].to_i
    url_end = args[:end_url].to_i
    
    puts "url_start is #{url_start}, url_end is #{url_end}"
    
    urls = Array.new
    
    File.open(RAILS_ROOT + '/tmp/alexa_top_100.csv','r+').each_line("\n") do |row|
      urls.push row
    end
    
    puts urls.size
    
    url_start.upto(url_end){ |i|
      columns = urls[i].split(",")
      url = columns[0]
      total_url = "http://www.#{url.to_s}"
            
      puts "\n url is #{total_url}"
      
      ff1 = FireWatir::Firefox.new(:profile => 'YSLOW')
      ff1.goto total_url
      sleep 10
      ff1.close
    }
    
    puts "\nDone"
  end
  
  desc  'Generate Page Speed Grades'
  task :pagespeed => :environment do
    print "Generating Page Speed Grades"
    puts "\nDone"
  end
  
end
