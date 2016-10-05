require 'rails_helper'

RSpec.describe GamesController, :type => :controller do

  let(:user) { User.create(name: "Alice", password: "pass")}

  before(:each) do
    allow(controller).to receive(:current_user).and_return(user)
    CardGenerator.create_cards
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
      get :show, id: game.id

      expect(response).to redirect_to(game_round_path(game_id: game.id, id: game.current_round.id))
    end
  end

  describe "#seer" do
    let(:game) { GameGenerator.create_game(user) }

    it "lets the seer look at another player's card" do
      6.times do
        user = User.create(password: "pass")
        game.players << Player.create(user_id: user.id)
      game.assign_cards
binding.pry
      end
      get :seer
binding.pry
      ActiveSupport::JSON.decode(response.body).should_not be_nil
    end
  end

end
