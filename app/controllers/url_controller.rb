class UrlController < ApplicationController
  
  def index
    @urls = Url.find(:all)
  end

  def show
    @url = Url.find(params[:id])
    
    @yslow_scores = @url.yslow2s.find(:all)
    
  end

end
