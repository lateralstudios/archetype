module Archetype
  module Attributes
    module SimpleForm
      class HasOne < Association
        def input(opts={})
          return polymorphic_input if attribute.polymorphic?
          super
        end

        def polymorphic_input
          collection = input_options[:collection]
          value = attribute.from(object)
          opts = input_options.except(:collection)
          form.input name, opts.merge(wrapper_html: {class: 'polymorphic-select'}) do
            h.concat(form.input_field "#{name}_id", as: :hidden, class: 'polymorphic-id')
            h.concat(form.input_field "#{name}_type", as: :hidden, class: 'polymorphic-type')
            h.concat(h.select_tag nil, collection, class: 'form-control polymorphic')
          end
        end
      end
    end
  end
end
