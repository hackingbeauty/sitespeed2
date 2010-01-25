class BeaconController < ApplicationController
  
  def yslow
    yslow_data = JSON.parse request.env['RAW_POST_DATA']

    # u = Url.find_by_url(url)
    # 
    # if u == nil
    #   u = Url.new
    #   u.url = yslow_data['u'] 
    #   u.save  
    # end
    
    grades = yslow_data['g']
    
    y = Yslow2.new # Yslow2 is the model that contains Yslow's 2nd ruleset
    
    y.details = yslow_data
    # see http://developer.yahoo.com/yslow/help/index.html
    
    y.w = yslow_data['w']   # total page size
    y.o = yslow_data['o']   # overall score
    y.r = yslow_data['r']   # total number of requests
    y.i = yslow_data['i']   # id of the ruleset used
    y.lt = yslow_data['lt'] # page load time
        
    y.user_agent = request.headers['User-Agent']    
    #y.url_id = u.id  
        
    y.ynumreq       = grades['ynumreq']['score']        # score for Make fewer HTTP Requests
    y.ycdn          = grades['ycdn']['score']           # score for Use a Content Delivery Network (CDN)
    y.yexpires      = grades['yexpires']['score']       # score for Add Expires Header
    y.ycompress     = grades['ycompress']['score']      # score for Compress components with gzip
    y.ycsstop       = grades['ycsstop']['score']        # score for Put CSS at top
    y.yjsbottom     = grades['yjsbottom']['score']      # score for Put JavaScript at bottm
    y.yexpressions  = grades['yexpressions']['score']   # score for Avoid CDD expressions
    y.yexternal     = grades['yexternal']['score']      # score for Make JavaScript and CSS external
    y.ydns          = grades['ydns']['score']           # score for Reduce DNS lookups
    y.yminify       = grades['yminify']['score']        # score for Minify JavaScript and CSS
    y.yredirects    = grades['yredirects']['score']     # score for Avoid URL redirects
    y.ydupes        = grades['ydupes']['score']         # score for Remove duplicate JavaScript and CSS
    y.yetags        = grades['yetags']['score']         # score for Configure entity tags (ETags)
    y.yxhr          = grades['yxhr']['score']           # score for Use GET for AJAX requests
    y.yxhrmethod    = grades['yxhrmethod']['score']     # score for Use GET for AJAX requests
    y.ymindom       = grades['ymindom']['score']        # score for Reduce the number of DOM elements
    y.yno404        = grades['yno404']['score']         # score for Avoid HTTP 404 (Not Found) error
    y.ymincookie    = grades['ymincookie']['score']     # score for Reduce cookie size
    y.ycookiefree   = grades['ycookiefree']['score']    # score for Use cookie-free domains
    y.ynofilter     = grades['ynofilter']['score']      # score for Avoide AlphaImageLoader filter
    y.yimgnoscale   = grades['yimgnoscale']['score']    # score for Do not scale images in HTML
    y.yfavicon      = grades['yfavicon']['score']       # score for Make favicon small and cacheable
    
    y.save
    
    puts '++++++++++++++++++++++++++++++++'
    puts "URL: #{yslow_data['u'] }"   
    puts '++++++++++++++++++++++++++++++++'
    
    render :nothing => true
  end
  
  # 
  # def page_speed
  #   puts request.env
  # end

end
