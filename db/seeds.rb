# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Card.create(role: "Seer", action: "Seer, wake up. You may look at another player’s card or two of the center cards.", team: "Villager")
Card.create(role: "Villager", action: "", team: "Villager")
Card.create(role: "Villager", action: "", team: "Villager")
Card.create(role: "Troublemaker", action: "Troublemaker, wake up. You may exchange cards between two other players.", team: "Villager")
Card.create(role: "Robber", action: "Robber, wake up. You may exchange your card with another player’s card, and then view your new card.", team: "Villager")
Card.create(role: "Werewolf", action: "Find out the other werewolf.", team: "Werewolf")
Card.create(role: "Werewolf", action: "Find out the other werewolf.", team: "Werewolf")

game = Game.create
game.create_rounds

alice = User.create(name: "Alice", password: "pass")
game.players << Player.create(user_id: alice.id, nickname: alice.name)
jason = User.create(name: "Jason", password: "pass")
game.players << Player.create(user_id: jason.id, nickname: jason.name)
tony = User.create(name: "Tony", password: "pass")
game.players << Player.create(user_id: tony.id, nickname: tony.name)
andrew = User.create(name: "Andrew", password: "pass")
game.players << Player.create(user_id: andrew.id, nickname: andrew.name)
colby = User.create(name: "Colby", password: "pass")
game.players << Player.create(user_id: colby.id, nickname: colby.name)
charlie = User.create(name: "Charlie", password: "pass")
game.players << Player.create(user_id: charlie.id, nickname: charlie.name)
khaleda = User.create(name: "Khaleda", password: "pass")
game.players << Player.create(user_id: khaleda.id, nickname: khaleda.name)

# game.assign_cards
game.save

