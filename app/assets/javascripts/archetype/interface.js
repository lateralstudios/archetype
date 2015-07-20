//= require bootstrap-sprockets
//= require archetype/adminlte/app.min
//= require archetype/moment
//= require archetype/bootstrap-datetimepicker.min

$(document).ready(function(){
  $('.datetimepicker').each(function(index, item){
    var $item = $(item),
        $hidden = $item.prev('input[type=\'hidden\']');
    $item.datetimepicker({});
    $item.on('changeDate', function(e){
      $hidden.val(moment.utc(e.date).format("YYYY-MM-DD HH:mm:ss UTC"));
    });
  });
});
