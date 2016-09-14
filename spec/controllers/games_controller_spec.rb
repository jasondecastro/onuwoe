require 'rails_helper'

RSpec.describe GamesController, :type => :controller do

  let(:user) { User.create(name: "Alice", password: "pass")}

  before(:each) do
    allow(controller).to receive(:current_user).and_return(user)
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
end
