$(document).ready(function(){
  $('.polymorphic-select').each(function(index, item){
    update_polymorphic_select($(item).closest('.polymorphic-select'));
  });

  $(document).on('change', '.polymorphic-select select.polymorphic', function(e){
    update_polymorphic_select($(this).closest('.polymorphic-select'));
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
