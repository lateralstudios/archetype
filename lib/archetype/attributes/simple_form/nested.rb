module Archetype
  module Attributes
    module SimpleForm
      class Nested < Input
        def input(opts={})
          h.capture do
            errors = object.errors.full_messages_for(name)
            if errors.any?
              h.concat(h.content_tag(:div, class: 'callout callout-danger') do
                h.content_tag(:p, errors.join('<br />').html_safe)
              end)
            end
            nested_objects.each do |nested|
              h.concat(nested_object(nested, opts))
            end
            h.concat(nested_object(new_nested_object, class: 'blueprint'))
            h.concat(h.content_tag(:p) do
              form.link_to_add "Add a #{nested_name.downcase}", name
            end)
          end
        end

        def nested_object(object, opts={})
          box_class = 'nested box box-default'
          box_class << " #{opts[:class]}" if opts[:class]
          box_class << " #{box_classes(object)}"
          form.fields_for(name, object) do |nested_form|
            h.content_tag(:div, class: box_class) do 
              h.concat(h.content_tag(:div, class: 'box-header with-border') do
                h.concat h.content_tag(:h3, nested_object_name(object), class: 'box-title')
                h.concat(h.content_tag(:div, class: 'box-tools pull-right') do
                  h.concat(h.button_tag(class: 'btn btn-box-tool', data: {widget: 'collapse'}) do
                    h.content_tag(:i, '', class: "fa #{object.persisted? ? 'fa-plus' : 'fa-minus'}")
                  end)
                  h.concat(nested_form.link_to_remove(class: 'btn btn-box-tool', data: {confirm: "Are you sure you want to delete this #{nested_name.downcase}?"}) do
                    h.content_tag(:i, '', class: 'fa fa-times')
                  end)
                end)
              end)
              h.concat(h.content_tag(:div, class: 'box-body') do
                nested_fields(nested_form, object, opts)
              end)
            end
          end
        end

        def nested_fields(nested_form, object, opts={})
          h.concat nested_form.input(:id, as: :hidden)
          attribute.nested.each do |attribute|
            h.concat attribute.field(nested_form, object).input(opts)
          end
        end

        def nested_objects
          existing = object.send(name)
          return existing if attribute.many? && existing.any?
          if attribute.many?
            []
          elsif existing
            [existing]
          else
            []
          end
        end

        def new_nested_object
          existing = object.send(name)
          if attribute.many?
            existing.new
          else
            object.send("build_#{name}")
          end
        end

        def nested_object_name(object)
          if object.persisted?
            attribute.name_from(object)
          else
            "New #{nested_name.downcase}"
          end
        end

        def box_classes(object)
          if object.persisted?
            'collapsed-box'
          end
        end

        def nested_name
          label.singularize
        end
      end
    end
  end
end
