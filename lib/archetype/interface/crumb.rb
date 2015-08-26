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

      class Builder < ModelBuilder
        dsl_accessor :path, :label, :position

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
