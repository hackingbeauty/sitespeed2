class UrlController < ApplicationController
  
  def index
    @urls = Url.find(:all)    
  end

  def show
    @the_url = Url.find(params[:id])
    @yslow2_scores = @the_url.yslow2s.find(:all)
    @page_speed_scores = @the_url.page_speeds.find(:all)
  end
  
  
  private

end
