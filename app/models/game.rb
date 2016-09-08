class Game < ApplicationRecord
	has_many :players

	def full?
		self.players.length == 7
	end

	def assign_cards
		# binding.pry
		cards = Card.all
		shuffled_cards = cards.shuffle

		self.players.each_with_index do |player, i|
			player.card = shuffled_cards[i]
			# binding.pry
			player.save
		end
		# binding.pry
		self.save
	end

	def start_game
		if self.full?
			self.assign_cards
			self.save
		end
	end

	def werewolves
	  	self.players.joins(:card).where("role = 'Werewolf'")
	end

	def werewolf_action(user)
	  	werewolf_names = self.werewolves.collect {|werewolf| werewolf.nickname }
	  	display_werewolves = werewolf_names.join(" and ")
	  	if self.werewolves.include?(user.player)
	  		"The Werewolves are #{display_werewolves}."
	  	end
	  	# if current_user is included in the array; display the other user
	end

	def seer
	  	self.players.joins(:card).where("role = 'Seer'")
	end

	def villagers
	  	self.players.joins(:card).where("role = 'Villager'")
	end

	def troublemaker
	  	self.players.joins(:card).where("role = 'Troublemaker'")
	end

	def robber
	  	self.players.joins(:card).where("role = 'Robber'")
	end

	private

	def current_game
		Game.find(params[:id])
	end

end
