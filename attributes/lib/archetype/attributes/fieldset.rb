module Archetype
  module Attributes
    class Fieldset
      attr_accessor :name, :label, :attributes, :options

      def initialize(name, opts={})
        @name = name.to_sym
        @label = opts.delete(:label)
        @attributes = opts.delete(:attributes){ [] }
        @options = opts
      end

      def label
        @label || name.to_s.humanize
      end

      def has_attribute?(name)
        attributes.include?(name)
      end
    end
  end
end
