module Archetype
  module Resourceful
    class Scope
      attr_accessor :name, :options
      
      def initialize(name, options={})
        self.name = name
        self.options = options || {}
      end

      def label
        options[:label] || name.to_s.humanize.titleize
      end

      def results(base, value=nil)
        if multiple? && value
          base.send(name, value)
        else
          base.send(name)
        end
      end

      def multiple?
        values.present?
      end

      def values
        options[:values]
      end

      class Builder < ModelBuilder
        dsl_accessor :label, :values

        def options
          {
            label: label,
            values: values
          }
        end

        def build(delegate)
          super
          Scope.new(name, options)
        end
      end
    end
  end
end
