class RoundsController < ApplicationController
  before_action :current_game

  def show
    # binding.pry
    # create play in round model
    # need to refactor this for current round
    round = current_game.current_round

    round.play
    head :ok

    redirect_to game_play_path(current_game)
  end

  def get_player
    respond_to do |format|
      format.json { render json: { user_id: current_user.id, role: current_user.player.card.role } }
    end
  end

  def play
    binding.pry
    @game = current_game

    @message = Message.new

    # LOBBY
    ActionCable.server.broadcast 'rounds',
          players: @game.players,
          game: @game.id.to_s,
          round: "0",
          html_result: resultify('/games/show.html.erb')
    head :ok
    sleep(10)
    # LOOK AT CARDS
    ActionCable.server.broadcast 'rounds',
          players: @game.players,
          game: @game.id.to_s,
          round: "1"
    head :ok
    sleep(10)
    # WEREWOLVES
    ActionCable.server.broadcast 'rounds',
          players: @game.players,
          game: @game.id.to_s,
          user: session[:user_id],
          round: "2"
    head :ok
    sleep(10)
    # SEER
    ActionCable.server.broadcast 'rounds',
          players: @game.players,
          game: @game.id.to_s,
          user: session[:user_id],
          round: "3"
    head :ok
    sleep(10)
    # ROBBER
    ActionCable.server.broadcast 'rounds',
          players: @game.players,
          game: @game.id.to_s,
          user: session[:user_id],
          round: "4"
    head :ok
    sleep(10)
    # TROUBLEMAKER
    ActionCable.server.broadcast 'rounds',
          players: @game.players,
          game: @game.id.to_s,
          user: session[:user_id],
          round: "5"
    head :ok
    sleep(10)
    # DISCUSSION TIME
    ActionCable.server.broadcast 'rounds',
          players: @game.players,
          game: @game.id.to_s,
          user: session[:user_id],
          round: "6"
    head :ok
    sleep(10)
    # VOTING
    ActionCable.server.broadcast 'rounds',
          players: @game.players,
          game: @game.id.to_s,
          user: session[:user_id],
          html_result: resultify('/games/voting_form.html.erb'),
          round: "7"
    head :ok
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

end
