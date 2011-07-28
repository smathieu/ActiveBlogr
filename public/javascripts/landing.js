$(function() {
  $('input.with_default').focus(function() {
    if (this.value == this.defaultValue) {
      this.value = ""
    }
  });

  $('input.with_default').focusout(function() {
    if (this.value == "") {
      this.value = this.defaultValue;
    }
  });

  $('#new_blog').validate();
});


