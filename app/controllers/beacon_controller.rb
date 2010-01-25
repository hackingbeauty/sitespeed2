class BeaconController < ApplicationController
  include BeaconHelper
  
  def bfast
    render :template => "beacon/yslow"
  end
  
  def yslow
    raw = JSON.parse request.env['RAW_POST_DATA']
    
    raw_s = raw.delete('s') # space id of the page - not used by showslow    
    raw_u = raw.delete('u') # url
    
    raw_g = raw.delete('g') # grades
    attrs = {:details=> raw_g, :user_agent=>request.headers['User-Agent']}

    raw.each { |k,v| # iterate over top level JSON keys
      attrs[k] =v
    }
    
    raw_g.each { |k,v| # iterate over nested yslow "grade" ("g") JSON keys
      attrs[k] =v['score']
    }
    
    attrs[:url_id] = url_id(raw_u)

    y = Yslow2.new     
    y.update_attributes(attrs)
    y.save
   
    render :nothing => true
  end
  
  
  def page_speed

    puts "++++++++++++++++++++++++++++++++++++"
    puts params
    puts "++++++++++++++++++++++++++++++++++++"
  
    attrs = params.dup
    attrs[:user_agent] = request.headers['User-Agent']
    
    p = PageSpeed.new
    p.update_attributes(attrs)
    p.save
  end

end
