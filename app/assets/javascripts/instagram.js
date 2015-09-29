// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function() {
  $('.instagram-tags-add').on('click', addTag)
  $('.instagram-tags-minus').on('click', minusTag)
});

addTag = function(e) {
  e.stopPropagation();
  e.preventDefault();
  var tagName = this.dataset.tagName
  addToTextBox(tagName)
  flipVisibilty($('.'+tagName))
};

minusTag = function(e) {
  e.stopPropagation();
  e.preventDefault();
  var tagName = this.dataset.tagName
  removeFromTextBox(tagName)
  flipVisibilty($('.'+tagName))
};

addToTextBox = function(tagName) {
  $('#instagram-tags')[0].value = $('#instagram-tags')[0].value + "," + tagName;
}

removeFromTextBox = function(tagName) {
  var tagArray = $('#instagram-tags')[0].value.split(',')
  console.log('boggs')
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