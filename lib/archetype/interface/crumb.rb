module Archetype
  module Interface
    class Crumb
      attr_accessor :name, :path, :options
      
      def initialize(name, path=nil, options={})
        self.name = name
        self.path = path
        self.options = options || {}
      end

      def label
        options[:label] || name.to_s.humanize.titleize
      end

      class Builder < ObjectBuilder
        def initialize(name)
          @name = name
        end

        def dsl_method
          super || name.to_sym
        end

        dsl_accessor :name, :path, :label, :position

        def options
          {
            label: label,
            position: position
          }.compact
        end

        def build(delegate)
          super
          Crumb.new(name, path, options)
        end
      end
    end
  end
end
