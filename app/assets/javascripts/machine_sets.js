// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function() {
  $('.add-machine').on('click', addMachineForm)
  $('.remove-new-machine').on('click', removeMachineForm)
  $('.machine-title').on('keyup', updateTitle)
});

addMachineForm = function(e) {
  e.stopPropagation();
  e.preventDefault();
  innerHtml = $('.new-machine-section')[0].innerHTML;
  return $.ajax({
    type: 'GET',
    url: '/machines/new_form',
    dataType: 'html',
    success: function(data, textStatus) {
      $('.new-machine-section').append(data);

      $('.remove-new-machine').unbind("click");
      $('.remove-new-machine').on("click", removeMachineForm);
      $('.machine-title').unbind("keyup");
      $('.machine-title').on("keyup", updateTitle);
    }
  });
};

removeMachineForm = function(e) {
  e.stopPropagation();
  e.preventDefault();
  this.parentNode.parentNode.remove();
};

updateTitle = function(e) {
  e.stopPropagation();
  e.preventDefault();
  console.log("testing");
  new_text = this.value;
  if (new_text == "")
  {
    new_text = "New Machine";
  }
  this.parentNode.parentNode.getElementsByClassName("new-machine-title")[0].innerHTML = new_text + minusButton();
};

function minusButton() {
  return "<button aria-label='Left Align' class='btn btn-default btn-xs pull-right remove-new-machine' type='button'><span aria-hidden='true' class='glyphicon glyphicon-minus'></span></button>"
};