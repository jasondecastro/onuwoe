class GameGenerator
  def self.create_game(user)
    game = Game.create(host: user.name, state: 0)
    player = Player.create(user_id: user.id, nickname: user.name)
    game.players << player
    game.create_rounds
    game.save
    game
  end

  def self.current_user_player(game, current_user)
	   game.players.each do |player|
      if player.user_id == current_user.id
        @player = player
      end
  	end
    @player
  end

 #  def self.display_form_for_action(params = {})
 #  end


end
