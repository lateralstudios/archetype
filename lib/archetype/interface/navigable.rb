module Archetype
  module Interface
    class Navigable
      attr_accessor :name, :path, :options
      
      def initialize(name, path, options={})
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
    end
  end
end
