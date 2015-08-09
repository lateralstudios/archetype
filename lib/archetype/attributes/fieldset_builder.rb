module Archetype
  module Attributes
    class FieldsetBuilder < ObjectBuilder
      dsl_accessor :label

      def build(delegate)
        super
        Fieldset.new(name, fieldset_options)
      end

      def fieldset_options
        {label: label}.merge(options)
      end

      def dsl_method
        "#{name}_fieldset".to_sym
      end
    end
  end
end
