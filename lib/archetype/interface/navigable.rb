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

      class Builder < ModelBuilder
        dsl_accessor :path, :label, :icon, :position

        def options
          {
            label: label,
            icon: icon,
            position: position
          }
        end

        def build(delegate)
          super
          Navigable.new(name, path, options)
        end
      end
    end
  end
end
