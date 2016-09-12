// what do we want to receive -- 

// setup timers to trigger send/get




App.rounds = App.cable.subscriptions.create('RoundsChannel', {
	received: function(data) {
		return $('#rounds').html(this.renderForm(data))
	},

	renderForm: function(data) {
		switch (data.role) {
			case "Seer":
				return this.seerForm(data);
			case "Robber":
				return this.robberForm(data);
			case "Troublemaker"
				return this.troublemakerForm(data);
		}
	},

	seerForm: function(data) {
		[{player_name: player.name, player_id: player.id}]
		`
		}
<form action="/search" accept-charset="UTF-8" method="get"><input name="utf8" type="hidden" value="✓">
	<label for="players">Players</label>
	<input type="hidden" name="players[player_id]" value=""><input type="radio" value="1" name="players[player_id]" id="players_player_id_1"><label for="players_player_id_1">Alice</label><input type="radio" value="2" name="players[player_id]" id="players_player_id_2"><label for="players_player_id_2">Jason</label><input type="radio" value="3" name="players[player_id]" id="players_player_id_3"><label for="players_player_id_3">Tony</label><input type="radio" value="4" name="players[player_id]" id="players_player_id_4"><label for="players_player_id_4">Andrew</label><input type="radio" value="5" name="players[player_id]" id="players_player_id_5"><label for="players_player_id_5">Colby</label><input type="radio" value="6" name="players[player_id]" id="players_player_id_6"><label for="players_player_id_6">Charlie</label><input type="radio" value="7" name="players[player_id]" id="players_player_id_7"><label for="players_player_id_7">Khaleda</label>
	<input type="submit" name="commit" value="Choose Player" data-disable-with="Choose Player">
</form>
		`
	}
})

