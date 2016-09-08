class Card < ApplicationRecord
  has_many :players

  # def werewolf_action
  	# find the 2 (all) werewolves
  	# Card.find_by(role: "Werewolf")
  	# find the players associated with the werewolves
  	# if current_user is included in the array; display the other user
  	

end
