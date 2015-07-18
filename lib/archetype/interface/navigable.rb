module Archetype
  module Interface
    class Navigable
      attr_accessor :name, :path, :options
      
      def initialize(name, path=nil, options={})
        self.name = name
        self.path = path
        self.options = options || {}
      end

      def label
        options[:label] || name.to_s.humanize.titleize
      end

      def icon
        options[:icon] || 'link'
      end

      def position
        options[:position]
      end

      class Builder < ObjectBuilder
        def initialize(name)
          @name = name
        end

        def dsl_method
          super || name.to_sym
        end

        dsl_accessor :name, :path, :label, :icon, :position

        def options
          {
            label: label,
            icon: icon,
            position: position
          }.compact
        end

        def build(&block)
          super
          Navigable.new(name, path, options)
        end
      end
    end
  end
end
