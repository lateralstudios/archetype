$(document).ready(function(){
  $('.polymorphic-select').each(function(index, item){
    update_polymorphic_select($(item).closest('.polymorphic-select'));
  });

  $(document).on('change', '.polymorphic-select select.polymorphic', function(e){
    update_polymorphic_select($(this).closest('.polymorphic-select'));
  });

  $('.nested.blueprint').remove();

  $(document).on('nested:fieldAdded', function(event){
    $.AdminLTE.boxWidget.activate();
  })

  $('.datetimepicker').each(function(index, item){
    var $item = $(item),
        $hidden = $item.prev('input[type=\'hidden\']');
    $item.datetimepicker({});
    $item.on('changeDate', function(e){
      $hidden.val(moment.utc(e.date).format("YYYY-MM-DD HH:mm:ss UTC"));
    });
  });

  $('.timepicker').each(function(index, item){
    var $item = $(item),
        $hidden = $item.prev('input[type=\'hidden\']');
    $item.datetimepicker({
      pickDate: false
    });
    $item.on('changeDate', function(e){
      $hidden.val(moment.utc(e.date).format("HH:mm:ss"));
    });
  });
});

function update_polymorphic_select(wrapper){
  var $wrapper    = $(wrapper),
      $select     = $wrapper.find('select.polymorphic'),
      $idField   = $wrapper.find('input.polymorphic-id'),
      $typeField = $wrapper.find('input.polymorphic-type'),
      selected   = $select.find('option:selected').val();
  extract_polymorphic_values(selected, $idField, $typeField);
}

function extract_polymorphic_values(value, idField, typeField){
  var split = value.split(':');
  if(!split.length > 1){
    idField.val('');
    typeField.val('');
  }else{
    idField.val(split[1]);
    typeField.val(split[0]);
  }
}
