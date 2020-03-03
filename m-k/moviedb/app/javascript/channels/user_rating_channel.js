import consumer from './consumer';

consumer.subscriptions.create('UserRatingChannel', {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    const input = $(`[data-movie-id='${data.movie_id}'] .js-user-rating`);
    if (input) {
      input.val(data.rate);
      input.rating('update', data.rate);
    }
  }
});
