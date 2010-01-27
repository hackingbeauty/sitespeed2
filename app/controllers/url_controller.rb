class UrlController < ApplicationController
  
  def index
    @urls = Url.find(:all)
    @grades = {}
    
    @urls.each do |u|
      y = u.yslow2s.find(:last)
      p = u.page_speeds.find(:last)
      
      @grades[:url] = u
      @grades[:url][:yslow] = y.o
      unless p == nil
        @grades[:url][:page_speed] = p.o
      end
    end
    
  end

  def show
    @url = Url.find(params[:id])
    @url_name = @url.url
    @yslow_scores = @url.yslow2s.find(:all)
  end

end
