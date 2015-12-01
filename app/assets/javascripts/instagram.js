// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function() {
  $('.instagram-tags-add').on('click', addTag)
  $('.instagram-tags-minus').on('click', minusTag)
  $('.instagram-remove-image').on('click', removeInstagramImage)
});

Array.prototype.clean = function(deleteValue) {
  for (var i = 0; i < this.length; i++) {
    if (this[i] == deleteValue) {         
      this.splice(i, 1);
      i--;
    }
  }
  return this;
};

addTag = function(e) {
  e.stopPropagation();
  e.preventDefault();
  var tagName = this.dataset.tagName
  addToTextBox(tagName)
  flipVisibilty($('.'+tagName+'-tag'))
};

removeInstagramImage = function(e) {
  e.stopPropagation();
  e.preventDefault();
  imageId = this.dataset.imageId;
  url = "/instagram/" + imageId;
  imageElement = "image-" + imageId;
  if (confirm("Are you sure you want to remove this image. The only way to bring it back is to remove and readd Instagram user. THIS CAN NOT BE UNDONE!")) {
    $.ajax({
      url: url,
      type: 'DELETE',
      dataType: "html",
      data: {
          image_id: imageId
      },
      success: function() {
          document.getElementById(imageElement).remove();
      },
      error: function(XMLHttpRequest, textStatus, errorThrown) {
          alert('An error occured.. ' + XMLHttpRequest.responseText + '..' + errorThrown);
      }
    });
  }
};


minusTag = function(e) {
  e.stopPropagation();
  e.preventDefault();
  var tagName = this.dataset.tagName
  removeFromTextBox(tagName)
  flipVisibilty($('.'+tagName+'-tag'))
};

addToTextBox = function(tagName) {
  var temp = $('#instagram-tags')[0].value + "," + tagName;
  temp = temp.split(',')
  $('#instagram-tags')[0].value = temp.clean("").join(',')
}

removeFromTextBox = function(tagName) {
  var tagArray = $('#instagram-tags')[0].value.split(',')
  var index = tagArray.indexOf(tagName);    // <-- Not supported in <IE9
  if (index !== -1) {
      tagArray.splice(index, 1);
  }

  tagArray.join(',')
  $('#instagram-tags')[0].value = tagArray
}

flipVisibilty = function(tags) {
  for (index = 0; index < tags.length; ++index) {
    if (tags[index].style.display == "none") {
      tags[index].style.display = ""
    }
    else {
      tags[index].style.display = "none"
    }
  }
}
