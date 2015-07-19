module Archetype
  module Attributes
    module SimpleForm
      class Association < Input
        def input_for(form)
          return nested_input_for(form) if nested?
          form.send form_method, name, input_options 
        end

        def nested_input_for(form)
          h = form.template
          h.content_tag(:div, class: 'well') do
            nested_objects(form).each do |object|
              h.concat nested_fields(form, object)
            end
            h.concat(h.content_tag(:p) do
              form.link_to_add "Add a package", name
            end)
          end
        end

        def nested_fields(form, object)
          form.fields_for(name, object) do |nested_form|
            form.template.concat nested_form.input(:id, as: :hidden)
            nested.each do |attribute|
              form.template.concat attribute.field.input_for(nested_form)
            end
            form.template.concat(nested_form.link_to_remove('Remove this package'))
          end
        end

        def nested_objects(form)
          existing = form.object.send(name)
          existing.any? ? existing : [existing.new]
        end

        def form_method
          input_options[:method] || :association
        end
      end
    end
  end
end
