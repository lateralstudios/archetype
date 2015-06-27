module Archetype
  module Interface
    class Crumb
      attr_accessor :name, :path, :options
      
      def initialize(name, path, options={})
        self.name = name
        self.path = path
        self.options = options || {}
      end

      def label
        options[:label] || name.to_s.humanize.titleize
      end
    end
  end
end
