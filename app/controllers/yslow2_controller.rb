class Yslow2Controller < ApplicationController

  def show
    @yslow2 = Yslow2.find(params[:id])
  end

end
