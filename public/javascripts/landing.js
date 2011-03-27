$(function() {
  $('input.email').focus(function() {
    if (this.value == this.defaultValue) {
      this.value = ""
    }
  });
});


