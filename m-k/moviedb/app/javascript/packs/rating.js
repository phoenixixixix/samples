document.addEventListener('DOMContentLoaded', () => {
  $('.js-user-rating')
    .rating({
      stars: 10,
      max: 10,
      step: 1,
      size: 'xs',
      theme: 'krajee-fas',
      showClear: false,
      starCaptions(value) {
        if (value === 1) {
          return '1 Star';
        }
        return `${value} Stars`;
      },
      starCaptionClasses(val) {
        if (val < 1) {
          return 'label label-default badge-secondary';
        }
        if (val < 4) {
          return 'label label-default badge-danger';
        }
        if (val < 8) {
          return 'label label-default badge-warning';
        }
        return 'label label-default badge-success';
      }
    })
    .on('rating:change', (event, value) => {
      if (value > 0) {
        const form = $(event.target).parents('form');
        form
          .one('submit', submitEvent => {
            submitEvent.preventDefault();
            const target = $(submitEvent.target);
            $.ajax({
              type: target.attr('method'),
              url: target.attr('action'),
              data: target.serialize(),
              error(jqXHR, exception) {
                // eslint-disable-next-line no-alert
                alert(exception);
              }
            });
          })
          .trigger('submit');
      }
    });
});
