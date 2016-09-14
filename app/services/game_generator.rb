class GameGenerator
  def self.create_game(user)
    game = Game.create(host: user.name, state: 0)
    player = Player.create(user_id: user.id, nickname: user.name)
    game.players << player
    game.create_rounds
    game.save
    game
  end
end
