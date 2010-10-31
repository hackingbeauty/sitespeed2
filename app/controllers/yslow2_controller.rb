class Yslow2Controller < ApplicationController

  def show
    @yslow2 = Yslow2.find(params[:id])
  end

  def all_scores
    @yscores = Url.find(params[:id]).yslow2s
    @scores = @yscores.find(:all)
  end

end
