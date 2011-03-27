$(function() {
  $('input.email').focus(function() {
    if (this.value == this.defaultValue) {
      this.value = ""
    }
  });

  $('input.email').focusout(function() {
    if (this.value == "") {
      this.value = this.defaultValue;
    }
  });
});


