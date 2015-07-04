module Archetype
  module Attributes
    module SimpleForm
      class Input < DelegateClass(Attribute)
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
            collection: collection
          }.compact.merge(options[:input])
        end
      end
    end
  end
end
