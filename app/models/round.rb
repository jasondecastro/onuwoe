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
    # binding.pry
    
    werewolf_action(current_user)
  end

  def round_3
    seer_action(current_user)
  end

  def round_4
    robber_action(current_user)
  end

  def round_5
    troublemaker_action(current_user)
  end

  def round_6
    # voting
  end

  def round_7
    # Display results
    # Who was voted?
    # Which team won?
  end

  def vote
    # render voting form for all players
  end

  def game_results
    # display results
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
      else
        "The Werewolves are finding each other."
      end
  end

  def seer
      self.game.players.joins(:card).where("role = 'Seer'")
  end

  def seer_action(user)
    if self.seer.include?(user.player)
      "Youa re the seer"
    end
  end

  def villagers
      self.game.players.joins(:card).where("role = 'Villager'")
  end

  def troublemaker
      self.game.players.joins(:card).where("role = 'Troublemaker'")
  end

  def troublemaker_action(user)
    if self.troublemaker.include?(user.player)
      "You are the Troublemaker, switch two cards (not your own)."
      # Form has to render
    else
      "The Troublemaker is being a sneaky sneaker. That sneak!"
    end
  end

  def robber
      self.game.players.joins(:card).where("role = 'Robber'")
  end

  def robber_action(user)
   if self.robber.include?(user.player)
     "You are the Robber, select the card you wish to steal."
     # Form has to render
   else
     "The Robber is being a rascally rascal. That rascal!"
   end
 end
end
