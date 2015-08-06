module Archetype
  module Attributes
    module SimpleForm
      class Association < Input
        def input(opts={})
          return nested_input_for(opts) if attribute.nested?
          super
        end

        def nested_input_for(opts)
          h = form.template
          h.content_tag(:div, class: 'well') do
            nested_objects.each do |nested|
              h.concat nested_fields(nested, opts)
            end
            h.concat(h.content_tag(:p) do
              form.link_to_add "Add a package", name
            end)
          end
        end

        def nested_fields(object, opts={})
          form.fields_for(name, object) do |nested_form|
            form.template.concat nested_form.input(:id, as: :hidden)
            attribute.nested.each do |attribute|
              form.template.concat attribute.field(nested_form, object).input(opts)
            end
            form.template.concat(nested_form.link_to_remove('Remove this package'))
          end
        end

        def nested_objects
          existing = object.send(name)
          return existing if attribute.many? && existing.any?
          if attribute.many?
            [existing.new]
          elsif existing
            [existing]
          else
            [object.send("build_#{name}")]
          end
        end

        def form_method
          options[:method] || :association
        end
      end
    end
  end
end
