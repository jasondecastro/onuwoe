class PlayersController < ApplicationController
  def show
    current_user.player.update(nickname: params[:nickname])
    @nickname = current_user.player.nickname
    
    respond_to do |format|
      format.json { render json: { notification: "<strong>" + @nickname + "</strong> has entered the game."} }
    end
  end
end
