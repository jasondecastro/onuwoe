class Game < ApplicationRecord
	has_many :players

	def full?
		self.players.length == 7
	end

	def assign_cards
		cards = Card.all
		shuffled_cards = cards.shuffle

		self.players.each_with_index do |player, i|
			player.card = shuffled_cards[i]
		end
	end

	def start_game
		if self.full?
			self.assign_cards
			self.save
		end
	end
end
