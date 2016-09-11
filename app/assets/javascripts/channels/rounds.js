$.ajax({
  url: '/get_player',
  type: 'POST',
  success: function(player) {
    App.cable.subscriptions.create({channel: 'RoundsChannel', user_id: player.user_id, role: player.role}, {
      received: function(data) {
        if (data.role == "Seer") {
          return $('#seer').append("<p>You are the <strong>Seer</strong></p>")
        } else if (data.role == "Robber") {
          return $('#robber').append("<p>The Robber is being rascally!</p>")
        } else if (data.role == "Villager") {
          return $('#villager').append("<p>You are the <strong>Villager</strong></p>")
        }
      }
    })
  },
})
