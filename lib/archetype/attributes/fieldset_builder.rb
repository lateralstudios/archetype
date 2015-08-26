module Archetype
  module Attributes
    class FieldsetBuilder < ModelBuilder
      dsl_accessor :label, :attributes

      def initialize(options={})
        super
        @attributes = options.delete(:attributes){ [] }
      end

      def build(delegate)
        super
        Fieldset.new(name, fieldset_options)
      end

      def fieldset_options
        {
          label: label,
          attributes: attributes
        }.merge(options)
      end

      def dsl_method
        "#{name}_fieldset".to_sym
      end
    end
  end
end
