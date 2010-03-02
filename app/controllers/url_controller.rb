# required libraries for alexa top sites web services
require "cgi"
require "base64"
require "openssl"
require "digest/sha1"
require "uri"
require "net/https"
require "rexml/document"
require "time"
require "hpricot"

class UrlController < ApplicationController
  
  def index
    @urls = Url.find(:all)
    @grades = Hash.new { |hash,key| hash[key] = [] }
    
    @urls.each do |u|
      y = u.yslow2s.find(:last)
      p = u.page_speeds.find(:last)
      @grades[u][0] = (y==nil) ? 'N/A' : y.o 
      @grades[u][1] = (p==nil) ? 'N/A' : p.o 
    end 
    
    doc = alexa_topsites
    
    (doc/'aws:sites'/'aws:site'/'aws:dataurl').each do |site|
      puts site.inner_html
    end
    
  end

  def show
    @url = Url.find(params[:id])
    @url_name = @url.url
    @yslow_scores = @url.yslow2s.find(:all)
  end
  
  
  private
  
  def alexa_topsites

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


    # print "\n\nRequest:\n\n"
    # print url

    # xml  = REXML::Document.new( Net::HTTP.get(url) )
    
    # print "\n\nResponse:\n\n"

    # xml.write
    
    xml = Hpricot.parse(Net::HTTP.get(url))

  end
  

end
