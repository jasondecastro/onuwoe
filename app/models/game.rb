class Game < ApplicationRecord
	has_many :players
	has_many :rounds
	has_many :messages
	accepts_nested_attributes_for :players


	def full?
		self.players.length == 7
	end

	def assign_cards
		cards = Card.all
		shuffled_cards = cards.shuffle

		self.players.each_with_index do |player, i|
			player.card = shuffled_cards[i]
			player.final_card = shuffled_cards[i].role
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
		Round.create(game_id: self.id, number: 0, current: true, complete: false)
		Round.create(game_id: self.id, number: 1, current: false, complete: false)
		Round.create(game_id: self.id, number: 2, current: false, complete: false)
		Round.create(game_id: self.id, number: 3, current: false, complete: false)
		Round.create(game_id: self.id, number: 4, current: false, complete: false)
		Round.create(game_id: self.id, number: 5, current: false, complete: false)
		Round.create(game_id: self.id, number: 6, current: false, complete: false)
		Round.create(game_id: self.id, number: 7, current: false, complete: false)
	end

	def current_round
		self.rounds.where(current: true).first
	end

	def change_round
  # binding.pry
		old_round = current_round
		old_round.update(complete: true, current: false)

		new_round_number = old_round.number + 1
		new_round = self.rounds.where(number: new_round_number).first

		new_round.update(current: true)
	end

	private

	def current_game
		Game.find(params[:id])
	end

end
