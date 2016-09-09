class Game < ApplicationRecord
	has_many :players
	has_many :rounds


	def full?
		self.players.length == 7
	end

	def assign_cards
		cards = Card.all
		shuffled_cards = cards.shuffle

		self.players.each_with_index do |player, i|
			player.card = shuffled_cards[i]
			player.save
		end
		self.save
	end

	def start_game
		if self.full?
			self.assign_cards
			self.save
		end
	end

	def create_rounds
		Round.create(game_id: self.id, number: 1, current: false, complete: false)
		Round.create(game_id: self.id, number: 2, current: false, complete: false)
		Round.create(game_id: self.id, number: 3, current: false, complete: false)
		Round.create(game_id: self.id, number: 4, current: false, complete: false)
		Round.create(game_id: self.id, number: 5, current: false, complete: false)
		Round.create(game_id: self.id, number: 6, current: false, complete: false)
		Round.create(game_id: self.id, number: 7, current: false, complete: false)
	end

	private

	def current_game
		Game.find(params[:id])
	end

end
