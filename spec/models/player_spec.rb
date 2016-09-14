require 'rails_helper'

describe Player do
  let(:some_game)   { Game.create }
  let(:some_user)   { User.create(name: Faker::Name.name, password: "pass") }
  let(:some_player) { Player.create(user_id: some_user.id, nickname: some_user.name) }
  let(:some_card)   { Card.create(role: Faker::Name.name, action: "Be Awesome") }

  describe '.create' do 
    it 'is created with user id and name' do 
      # binding.pry
      expect(some_user.name).to eq(some_player.nickname)
    end

    it 'has a card' do
      some_game.players << some_player
      some_player.card_id = 1
      expect(some_player.card_id).to eq(1)
    end

    it 'has a role' do
            # binding.pry
      some_game.players << some_player
      some_player.card_id = some_card.id
      expect(some_player.card.role).to eq(some_card.role)
    end
  end

end