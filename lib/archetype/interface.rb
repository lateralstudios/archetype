module Archetype
  class Interface

    def navigable(name, path, opts={})
      navigation.add_parent(name, path, opts)
    end

    def navigation
      @navigation ||= Navigation.new
    end

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

    class Navigation < SimpleDelegator
      attr_accessor :navigation

      def initialize
        self.navigation = []
        super(navigation)
      end

      def add_parent(name, path, opts={})
        index = opts.delete(:position)    
        navigable = Navigable.new(name, path, opts)
        if index.nil?
          self.navigation.push(navigable)
        else
          self.navigation.insert(index, navigable)
        end
      end
    end
  end
end
