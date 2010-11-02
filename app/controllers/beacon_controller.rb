class BeaconController < ApplicationController
    
  def yslow
    
    yslow2_attrs = {}
    grades = {}
    
    # =  Crack::JSON.parse(@stats)
    puts "============="
    puts "raw_data is is #{request.env['RAW_POST_DATA']}"
    puts "============="
    
    
    raw_data = JSON.parse request.env['RAW_POST_DATA']
        
    grade_data = raw_data.delete('g') # all grades 
    
    puts "============="
    puts "raw_data.to_json is #{raw_data.to_json}"
    puts "============="
     
    site_url = CGI::unescape(raw_data.delete('u'))
    u = Url.find_or_create_by_url_name(site_url)
    
    yslow2_attrs = {
      :user_agent=>request.headers['User-Agent']
    }
    
    raw_data.each { |k,v| # iterate over top level JSON keys and populate attrs hash
      puts "k is #{k}"
      yslow2_attrs[k] = v.to_json
      # if k == "stats"
      #   puts "stats value v is #{v.to_json}"
      # end
    }
    
    yslow2_attrs[:url_id] = u.id
        
    grade_data.each { |k,v| # iterate over grades
      grades[k] = v
      # puts "------grades[k]"
      # puts "#{grades[k]}"
    }
            
    y = Yslow2.new
    y.update_attributes(yslow2_attrs)
    y.save
    
    grades[:yslow2_id] = y.id
    
    g = Grade.new
    g.update_attributes(grades)
    g.save
  
    render :nothing => true
    
  end
  
  def page_speed  
    # attrs = params.clone
    # 
    # puts "-------"
    # puts attrs[:u]
    # puts "-------"
    # 
    # 
    # attrs[:user_agent] = request.headers['User-Agent']
    # 
    # attrs.delete('action')
    # attrs.delete('controller')
    # 
    # site_url = attrs.delete('u')
    # site_url_clean1 = site_url
    # site_url_clean2 = site_url_clean1.gsub(/(http|https):\/\//,"") #apparently, PageSpeed rips out the "www" when submitting URL via beacon - YSLOW does NOT strip out "www"
    # site_url_lookup = site_url_clean2.gsub("/","")
    # 
    # puts "++++++++++++++++++++"
    # puts site_url
    # puts "site_url_clean1: #{site_url_clean1}"
    # puts "site_url_lookup: #{site_url_lookup}"
    # puts "++++++++++++++++++++"
    # 
    # u = Url.find_or_create_by_url_name(site_url_lookup)
    # attrs[:url_id] = u.id
    #   
    # p = PageSpeed.new
    # p.update_attributes(attrs)
    # p.save
    # 
    # render :nothing => true

  end

end
