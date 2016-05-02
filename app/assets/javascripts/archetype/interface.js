//= require bootstrap-sprockets
//= require archetype/adminlte/app.min
//= require archetype/moment
//= require archetype/bootstrap-datetimepicker.min
//= require archetype/wysiwyg

$(document).ready(function(){
  Archetype.wysiwyg.init();

  function resizeAffix(){
    $('[data-spy=\'affix\']').each(function(idx, item){
      var $item = $(item);
      $item.width($item.parent().width());
    });
  }

  $(window).resize(function () {
    resizeAffix();
  });
  resizeAffix();
});
