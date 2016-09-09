class Round < ApplicationRecord
  belongs_to :game

  def werewolves
      self.players.joins(:card).where("role = 'Werewolf'")
  end

  def werewolf_action(user)
      werewolf_names = self.werewolves.collect {|werewolf| werewolf.nickname }
      display_werewolves = werewolf_names.join(" and ")
      if self.werewolves.include?(user.player)
        "The Werewolves are #{display_werewolves}."
      end
  end

  def seer
      self.players.joins(:card).where("role = 'Seer'")
  end

  def seer_action(user)
    if self.seer.include?(user.player)
      "You are the Seer, select the card you wish to see."
    end
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
end
