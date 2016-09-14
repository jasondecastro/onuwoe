require 'rails_helper'

RSpec.describe GamesController, :type => :controller do

  let(:user) { User.create(name: "Alice", password: "pass")}

  before(:each) do
    allow(controller).to receive(:current_user).and_return(user)

    Card.create(role: "Seer", action: "Seer, wake up. You may look at another player’s card or two of the center cards.", team: "Villager")
    Card.create(role: "Villager", action: "", team: "Villager")
    Card.create(role: "Villager", action: "", team: "Villager")
    Card.create(role: "Troublemaker", action: "Troublemaker, wake up. You may exchange cards between two other players.", team: "Villager")
    Card.create(role: "Robber", action: "Robber, wake up. You may exchange your card with another player’s card, and then view your new card.", team: "Villager")
    Card.create(role: "Werewolf", action: "Find out the other werewolf.", team: "Werewolf")
    Card.create(role: "Werewolf", action: "Find out the other werewolf.", team: "Werewolf")
  end

  describe "#create" do
    it "creates a game and a player, associated with the current user" do
      expect do
        post :create
      end.to change {Game.count}.from(0).to(1)

      expect(Player.count).to eq(1)
      game = Game.first
      player = Player.first

      expect(player.game).to eq(game)
      expect(player.user).to eq(user)
    end

    it "creates rounds, associated with the game" do
      post :create
      game = Game.first

      expect(game.rounds.count).to eq(8)
    end
  end

  describe "#show" do
    let(:game) { GameGenerator.create_game(user) }

    it "waits for all players before starting a game" do
      get :show, id: game.id

      expect(game.rounds.first.complete).to eq(false)
    end

    it "begins gameplay when the game is full" do
      6.times do
        user = User.create(password: "pass")
        game.players << Player.create(user_id: user.id)
      end
      game.change_round
      get :show, id: game.id

      binding.pry

      expect(response).to redirect_to(game_round_path(game_id: game.id, id: game.current_round.id))
    end
  end
end
