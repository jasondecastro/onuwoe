class PlayersController < ApplicationController
  def show
    @nickname = params[:nickname]
    respond_to do |format|
      format.json { render json: { notification: "<strong>" + @nickname + "</strong> has entered the game."} }
    end
  end
end
