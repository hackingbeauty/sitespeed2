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
  end

  def show
    @url = Url.find(params[:id])
    @url_name = @url.url
    @yslow_scores = @url.yslow2s.find(:all)
  end

end