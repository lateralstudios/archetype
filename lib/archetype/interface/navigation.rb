module Archetype
  class Interface
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
