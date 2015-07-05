module Archetype
  module Attributes
    module SimpleForm
      class Uploader < Input
        def input_for(form)
          hint = "Current file: #{filename(form.object)}"
          options = input_options.merge(hint: hint)
          form.send(form_method, name, options)
          # form.template.render 'archetype/attributes/inputs/uploader', f: form, attribute: self
          # template = form.template
          # template.capture do
          #   form.send(form_method, name, input_options) do
          #     template.concat short_format(form.object)
          #     template.concat form.input_field(name)
          #   end
          # end
        end
      end
    end
  end
end
