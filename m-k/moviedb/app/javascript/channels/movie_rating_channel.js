import consumer from './consumer';

consumer.subscriptions.create('MovieRatingChannel', {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    $(`[data-movie-id='${data.id}']`)
      .find('.js-rating-value')
      .text(data.rating);
  }
});
