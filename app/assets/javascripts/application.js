// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require ckeditor/init
//= require_tree .

// $(document).ready(function() {
//   loadImage();
// });

$(function() {
    $('.confirm').click(function() {
        return window.confirm("Are you sure? This will take a couple minutes to reload all the images.");
    });
});

// loadImage = function(e) {
//   jQuery.each($('.instgram-ajax'), function(index, value) {
//     console.log("boogers");
//     var user_id = escapeHtml(this.dataset.userId);
//     var img = this;
//     if (!img.classList.contains('loaded')) {
//       return $.ajax({
//         type: 'GET',
//         url: "/instagram_images/"+user_id,
//         dataType: 'json',
//         beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
//         success: function(data, textStatus) {
//           img.alt = data.title;
//           img.src = data[size];
//           img.classList.add('loaded');
//         }
//       });
//     }
//   });
// };

// var entityMap = {
//     "&": "&amp;",
//     "<": "&lt;",
//     ">": "&gt;",
//     '"': '&quot;',
//     "'": '&#39;',
//     "/": '&#x2F;'
//   };

//   function escapeHtml(string) {
//     return String(string).replace(/[&<>"'\/]/g, function (s) {
//       return entityMap[s];
//     });
//   }