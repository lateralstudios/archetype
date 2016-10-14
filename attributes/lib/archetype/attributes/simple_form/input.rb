module Archetype
  module Attributes
    module SimpleForm
      class Input
        attr_reader :attribute, :form, :object, :options
        delegate :name, :label, to: :attribute

        def initialize(attribute, form, object=nil)
          @attribute = attribute
          @object = object || form.object
          @form = form
          @options = attribute.options[:input].try(:deep_dup) || {}
        end

        def input(opts={})
          form.send form_method, name, input_options.deep_merge(opts) 
        end

        def as
          options[:as]
        end

        def partial
          options[:partial]
        end

        def form_method
          options[:method] || :input
        end

        def collection
          collection = options.delete(:collection) || attribute_options[:collection] || return
          collection.respond_to?(:call) ? collection.call(h, object) : collection
        end

        def attribute_options
          attribute.options
        end

        def input_options
          {
            as: as,
            collection: collection,
            label: label,
            input_html: input_html
          }.compact.deep_merge(options.except(:as, :partial, :method))
        end

        def input_html
          @input_html ||= options.delete(:html) || options.delete(:input_html)
          @input_html ? html_options.deep_merge(@input_html) : html_options
        end

        def html_options
          {}
        end

        def h
          form.template
        end
      end
    end
  end
end
