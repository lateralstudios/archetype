module Archetype
  module Attributes
    module SimpleForm
      class Input < DelegateClass(Types::Attribute)
        def input_for(form)
          form.send form_method, name, input_options 
        end

        def form_method
          input_options[:method] || :input
        end

        def collection
          options[:collection]
        end

        def options
          {input: {}}.merge(super)
        end

        def input_options
          {
            collection: collection,
            label: label
          }.compact.merge(options[:input])
        end
      end
    end
  end
end
