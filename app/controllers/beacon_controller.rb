class BeaconController < ApplicationController
    
  def yslow
    raw = JSON.parse request.env['RAW_POST_DATA']
    raw_g = raw.delete('g') # grades

    attrs = {
      :user_agent=>request.headers['User-Agent']
    }
    
    raw.each { |k,v| # iterate over top level JSON keys
      attrs[k] = v
    }
    
    raw_g.each { |k,v| # iterate over nested yslow "grade" ("g") JSON keys
      attrs[k] =v['score']
    }
        
    site_url = CGI::unescape(attrs.delete('u'))
    site_url_clean1 = site_url.match(/(http|https):\/\/[a-z0-9]*\.[a-z0-9]*\.[a-z]*(\/)/).to_s
    site_url_clean2 = site_url_clean1.gsub(/(http|https):\/\/[a-z0-9]*\./,"")
    site_url_lookup = site_url_clean2.gsub("/","")
    
    puts "++++++++++++++++++++"
    puts site_url
    puts "site_url_clean1: #{site_url_clean1}"
    puts "site_url_lookup: #{site_url_lookup}"
    puts "++++++++++++++++++++"
    
    u = Url.find_or_create_by_url_name(site_url_lookup)
    attrs[:url_id] = u.id
  
    y = Yslow2.new     
    y.update_attributes(attrs)
    y.save
    
    render :nothing => true
    
  end
  
  
  def page_speed  
    attrs = params.clone
    
    puts "-------"
    puts attrs[:u]
    puts "-------"
    
    
    attrs[:user_agent] = request.headers['User-Agent']
    
    attrs.delete('action')
    attrs.delete('controller')
    
    site_url = attrs.delete('u')
    site_url_clean1 = site_url
    site_url_clean2 = site_url_clean1.gsub(/(http|https):\/\//,"") #apparently, PageSpeed rips out the "www" when submitting URL via beacon - YSLOW does NOT strip out "www"
    site_url_lookup = site_url_clean2.gsub("/","")
    
    puts "++++++++++++++++++++"
    puts site_url
    puts "site_url_clean1: #{site_url_clean1}"
    puts "site_url_lookup: #{site_url_lookup}"
    puts "++++++++++++++++++++"
    
    u = Url.find_or_create_by_url_name(site_url_lookup)
    attrs[:url_id] = u.id
      
    p = PageSpeed.new
    p.update_attributes(attrs)
    p.save
    
    render :nothing => true

  end

end
