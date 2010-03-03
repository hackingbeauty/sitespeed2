require "hpricot"

namespace :grades do
  
  desc "Generate Yslow! and Page Speed Grades"
  task :all => [:alexa, :yslow, :pagespeed]

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
    (xml/'aws:sites'/'aws:site'/'aws:dataurl').each do |site|
      # puts site.inner_html
      site_name = site.inner_html
      u = Url.find_or_create_by_url(CGI::unescape site_name)
      u.country = "US"
      u.save
    end
    puts "\nDone"
  end
  
  desc "Generate Yslow! Grades"
  task :yslow => :environment do
    print "Generating Yslow! Grades"
    puts "\nDone"
  end
  
  desc  'Generate Page Speed Grades'
  task :pagespeed => :environment do
    print "Generating Page Speed Grades"
    puts "\nDone"
  end
  
end
