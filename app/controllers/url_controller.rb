class UrlController < ApplicationController
  
  def index
    @urls = Url.find(:all)
    @grades = Hash.new { |hash,key| hash[key] = { } }
    
    @urls.each do |u|
      y = u.yslow2s.find(:last)
      p = u.page_speeds.find(:last)
      @grades[u].store(:yslow, y.o) unless y == nil
      @grades[u].store(:page_speed, p.o) unless p == nil
    end 
  end

  def show
    @url = Url.find(params[:id])
    @url_name = @url.url
    @yslow_scores = @url.yslow2s.find(:all)
  end

end
