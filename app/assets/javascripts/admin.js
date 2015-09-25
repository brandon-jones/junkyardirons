// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function() {
  $('#signups_enabled').on('click', updateSignupStatus)

});

updateSignupStatus = function(e) {
  console.log("boogers");
  ssr = this.checked
  return $.ajax({
    type: 'POST',
    url: '/admin/update_signup_status',
    dataType: 'json',
    data: {
      signups_enabled: ssr
    },
    beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
    success: function(data, textStatus) {
      console.log('testing');
      $('#'+editLink.replace('.','\\.'))[0].dataset.userLink = data.link;
      $('#link-to-site').val('');
      $('#exampleModal').modal('hide')
    }
  });
};