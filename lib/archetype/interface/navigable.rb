module Archetype
  class Interface
    class Navigable
      attr_accessor :name, :path, :options
      
      def initialize(name, path, options={})
        self.name = name
        self.path = path
        self.options = options || {}
      end

      def title
        options[:title] || name.to_s.humanize.titleize
      end

      def icon
        options[:icon] || 'link'
      end
    end
  end
end
