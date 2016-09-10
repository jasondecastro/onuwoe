class Round < ApplicationRecord
  belongs_to :game

  def play
    binding.pry
    #refactor into case statement
    if self.number == 1
      round_1
    elsif self.number == 2
      round_2
    end
  end

  def round_1
    @game = self.game
    if !@game.players.last.card
      @game.assign_cards
    end

    #@game.update(state: 1)
    @game.players.each do |player|
      if player.user_id == current_user.id
        @player = player
      end
    end
  end

  def round_2
    werewolf_action()
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
