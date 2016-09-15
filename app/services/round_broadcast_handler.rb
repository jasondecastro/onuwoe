class RoundBroadcastHandler
  def broadcast(round, duration)
    @game = current_game

    ActionCable.server.broadcast 'rounds',
      players: @game.players,
      game: @game.id.to_s,
      user: session[:user_id],
      round: round,
      results: @game.players.where(votes: @game.players.maximum('votes')).last.nickname
      winners: @game.players.where(votes: @game.players.maximum('votes')).last.card.team
    head :ok
    sleep(duration) unless duration == nil
  end

  def self.broadcast_all_rounds
    broadcast(1, 10)
    broadcast(2, 20)
    broadcast(3, 20)
    broadcast(4, 10)
    broadcast(5, 20)
    broadcast(7, 20)
    broadcast(8, 20)
    broadcast(9)
  end
end
