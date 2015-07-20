module Archetype
  module Attributes
    module SimpleForm
      class Input < DelegateClass(Attribute)
        def input_for(form)
          form.send form_method, name, input_options 
        end

        def as
          user_options[:as]
        end

        def partial
          user_options[:partial]
        end

        def form_method
          user_options[:method] || :input
        end

        def collection
          options[:collection]
        end

        def user_options
          options[:input] ||= {}
        end

        def input_options
          {
            as: as,
            collection: collection,
            label: label,
            input_html: input_html_options(user_options.delete(:html) || user_options.delete(:input_html)),
          }.compact.merge(user_options)
        end

        def input_html_options(options={})
          {
          }.merge(options || {})
        end
      end
    end
  end
end
