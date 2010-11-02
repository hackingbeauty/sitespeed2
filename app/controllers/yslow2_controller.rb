class Yslow2Controller < ApplicationController

  def show
    @yslow2 = Yslow2.find(params[:id])
  end

  def all_components
    @domain = Url.find(params[:id]).url_name
    @yscores = Url.find(params[:id]).yslow2s.find(:last)
    @stats = JSON.parse(@yscores.stats)
  end

end
