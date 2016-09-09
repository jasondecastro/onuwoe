class RoundsController < ApplicationController
  before_action :current_game


  def round1
    @game = current_game
    binding.pry
    if !@game.players.last.card
      @game.assign_cards
    end
    @game.update(state: 1)
    @game.players.each do |player|
      if player.user_id == current_user.id
        @player = player
      end
    end
  end

  def round2

  end

end
