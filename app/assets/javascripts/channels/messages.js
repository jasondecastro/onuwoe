App.messages = App.cable.subscriptions.create('MessagesChannel', {
	received: function(data) {
		debugger;
		return $('.card-text').append(this.renderMessage(data))
	},

	renderMessage: function(data) {
		return "<p><strong>" + data.player + "</strong>: " + data.message + "</p>"
	}
})