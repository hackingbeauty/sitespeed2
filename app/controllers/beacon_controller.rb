class BeaconController < ApplicationController
    
  def yslow
    raw = JSON.parse request.env['RAW_POST_DATA']
    
    raw_g = raw.delete('g') # grades

    attrs = {
      #:details=> raw_g, 
      :user_agent=>request.headers['User-Agent']
    }
    
    raw.each { |k,v| # iterate over top level JSON keys
      attrs[k] =v
    }
    
    raw_g.each { |k,v| # iterate over nested yslow "grade" ("g") JSON keys
      attrs[k] =v['score']
    }
    
    site_url = CGI::unescape(attrs.delete('u'))
    site_url_clean = site_url.gsub("http://","")

    u = Url.find_or_create_by_url(site_url_clean)
    attrs[:url_id] = u.id
  
    y = Yslow2.new     
    y.update_attributes(attrs)
    y.save
    
    render :nothing => true
  end
  
  
  def page_speed  
    attrs = params.clone
    
    attrs[:user_agent] = request.headers['User-Agent']
    
    attrs.delete('action')
    attrs.delete('controller')

    u = Url.find_or_create_by_url(CGI::unescape attrs.delete('u'))
    attrs[:url_id] = u.id
      
    p = PageSpeed.new
    p.update_attributes(attrs)
    p.save
    
    render :nothing => true

  end

end
