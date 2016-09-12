$.ajax({
  url: '/get_player',
  type: 'POST',
  success: function(player) {
    App.cable.subscriptions.create({channel: 'RoundsChannel', user_id: player.user_id, role: player.role}, {
      received: function(data) {
        if (player.role == "Seer") {
          
        } else if (player.role == "Robber") {
          
        } else if (player.role == "Werewolf") {
          return $('#seer').append("<%= @game.current_round.werewolf_action(current_user) %>")
        }
      }
    })
  },
})

