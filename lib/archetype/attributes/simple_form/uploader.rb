module Archetype
  module Attributes
    module SimpleForm
      class Uploader < Input
        def input(opts={})
          hint = "Current file: #{attribute.filename(object)}"
          opts = {hint: hint}.merge(opts)
          super(opts)
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
