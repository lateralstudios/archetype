//
//= require froala_editor.min.js
//

var Archetype = window.Archetype || {};

Archetype.wysiwyg = function() {
  'use strict';

  function init(el, opts) {
    if(!el) var el = $('.wysiwyg');
    var params = getParams();
    var defaults = {
      inlineMode: false,
      imageUploadURL: "/admin/froala_assets?" + params,
      imageUploadParam: "image[file]",
      allowedImageTypes: ["jpeg", "jpg", "png", "gif"]
    }
    var options = $.extend({}, defaults, opts);
    el.editable(options).on('editable.imageError', handleUploadError)
  }

  function basic(el, opts){
    if(!el) var el = $('.wysiwyg-basic');
    var defaults = {
      inlineMode: false,
      buttons: ['bold', 'italic', 'underline']
    }
    var options = $.extend({}, defaults, opts);
    el.editable(options);
  }

  function getParams() {
    var csrf_token = $('meta[name=csrf-token]').attr('content');
    var csrf_param = $('meta[name=csrf-param]').attr('content');
    var params = '';
    if (csrf_param !== undefined && csrf_token !== undefined) {
      params = csrf_param + "=" + encodeURIComponent(csrf_token);
    }
    return params;
  }

  function handleUploadError (e, editor, error) {
    var message = error.code == 0 ? error.message.file.join('\n') : error.message;
    alert(message);
  }

  return {
    init: init,
    basic: basic
  };
}();
