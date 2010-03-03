class UrlController < ApplicationController
  
  def index
    @urls = Url.paginate :page => params[:page], :order => 'created_at DESC'
    
    
    # @alexa_urls = Url.find(:all)
    # @grades = Hash.new { |hash,key| hash[key] = [] }
    # 
    # @alexa_urls.each do |u|
    #   y = u.yslow2s.find(:last)
    #   p = u.page_speeds.find(:last)
    #   @grades[u][0] = (y==nil) ? 'N/A' : y.o 
    #   @grades[u][1] = (p==nil) ? 'N/A' : p.o 
    # end 
    # 
    # doc = alexa_topsites
    # 
    # (doc/'aws:sites'/'aws:site'/'aws:dataurl').each do |site|
    #   puts site.inner_html
    # end
    
  end

  def show
    @url = Url.find(params[:id])
    @url_name = @url.url
    @yslow_scores = @url.yslow2s.find(:all)
  end
  
  
  private

end
