class Round < ApplicationRecord
  belongs_to :game

  def play
    # binding.pry
    #refactor into case statement
    if self.number == 1
      round_1
    elsif self.number == 2
      round_2
    end
  end

  def display_page(user)
    if self.number == 1 && user.player.card.role == "Werewolf"
      "'werewolf'"
    elsif self.number == 1
      "'werewolf_awake'"
    end
  end

  def result_page(user, params)
    binding.pry
    if self.number == 1 && user.player.card.role == "Seer"
      @role = params[:role]
      "'seer_results', locals: { name: #{params[:name]}, role: #{@role}}'"
      binding.pry
    elsif self.number == 4 && user.player.card.role == "Robber"
    
    end
  end

  def round_1
    @game = self.game
    if !@game.players.last.card
      @game.assign_cards
    end
  end

  def round_2
    binding.pry
    @game = current_game
    @round = @game.current_round
    werewolf_action(current_user)
  end

  def werewolves
    # binding.pry
    self.game.players.joins(:card).where("role = 'Werewolf'")
  end

  def werewolf_action(user)
      werewolf_names = self.werewolves.collect {|werewolf| werewolf.nickname }
      display_werewolves = werewolf_names.join(" and ")
      if self.werewolves.include?(user.player)
        "The Werewolves are #{display_werewolves}."
      end
  end

  def seer
      self.game.players.joins(:card).where("role = 'Seer'")
  end

  def seer_action(user)
    if self.seer.include?(user.player)
      "You are the Seer, select the card you wish to see."
    end
  end

  def villagers
      self.game.players.joins(:card).where("role = 'Villager'")
  end

  def troublemaker
      self.game.players.joins(:card).where("role = 'Troublemaker'")
  end

  def robber
      self.game.players.joins(:card).where("role = 'Robber'")
  end
end
