class CardGenerator
  def self.create_cards
    Card.create(role: "Seer", action: "Seer, wake up. You may look at another player’s card or two of the center cards.", team: "Villager")
    Card.create(role: "Villager", action: "", team: "Villager")
    Card.create(role: "Villager", action: "", team: "Villager")
    Card.create(role: "Troublemaker", action: "Troublemaker, wake up. You may exchange cards between two other players.", team: "Villager")
    Card.create(role: "Robber", action: "Robber, wake up. You may exchange your card with another player’s card, and then view your new card.", team: "Villager")
    Card.create(role: "Werewolf", action: "Find out the other werewolf.", team: "Werewolf")
    Card.create(role: "Werewolf", action: "Find out the other werewolf.", team: "Werewolf")
  end
end
