// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function() {
  $('.add-machine').on('click', addMachineForm)
  $('.machine-remove').on('click', removeMachineForm)
  $('.machine-title').on('keyup', updateTitle)
  $('.machine-images-remove').on('click', removeImageFromMachine)
});

addMachineForm = function(e) {
  e.stopPropagation();
  e.preventDefault();
  innerHtml = $('#accordion.panel-group')[0].innerHTML;
  return $.ajax({
    type: 'GET',
    url: '/machines/new_form',
    dataType: 'html',
    success: function(data, textStatus) {
      $('#accordion.panel-group').append(data);

      $('.machine-remove').unbind("click");
      $('.machine-remove').on("click", removeMachineForm);
      $('.machine-title').unbind("keyup");
      $('.machine-title').on("keyup", updateTitle);
    }
  });
};

removeMachineForm = function(e) {
  e.stopPropagation();
  e.preventDefault();
  console.log("hello");
  error = false;
  panel = this.parentNode.parentNode.parentNode;
  panel_title = panel.getElementsByClassName("machine-title")[0].value;
  panel_description = panel.getElementsByClassName("machine-description")[0].value;
  panel_images = panel.getElementsByClassName("machine-images")[0].files.length;

  if (panel_title.length > 0)
  {
    error = true;
  }

  if (panel_description.length > 0)
  {
    error = true;
  }

  if (panel_description > 0)
  {
    error = true;
  }

  if (error == true)
  {
    if (confirm('You have unsaved work. Are you sure you want to remove it. THIS CAN NOT BE UNDONE!')) {
      panel.remove();
    } else {
        // Do nothing!
    }
  }
  else 
  {
    panel.remove();
  }
};


removeImageFromMachine = function(e) {
  e.stopPropagation();
  e.preventDefault();
  id = this.dataset.id;
  console.log("hello");
  innerHtml = $('#accordion.panel-group')[0].innerHTML;
  return $.ajax({
    type: 'DELETE',
    url: '/images/'+id,
    dataType: 'html',
    success: function(data, textStatus) {
      $('#image-id-'+id).remove();
    }
  });
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
  this.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.children[0].getElementsByTagName("a")[0].text = new_text;
};

function minusButton() {
  return "<button aria-label='Left Align' class='btn btn-default btn-xs pull-right remove-new-machine' type='button'><span aria-hidden='true' class='glyphicon glyphicon-minus'></span></button>"
};