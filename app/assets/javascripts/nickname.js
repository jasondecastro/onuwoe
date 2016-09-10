$(function() {
  addFormEventHandler()
})

function addFormEventHandler() {
  console.log('hi')


    $('form.form-stuff').on('ajax:complete', function(e, request, status){
      $('.card-text').append(`<p>${request.responseJSON.notification}</p>`);
      $('#nickname').val('');
  })
}