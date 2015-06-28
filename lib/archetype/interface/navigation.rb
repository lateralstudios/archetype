module Archetype
  module Interface
    class Navigation < SimpleDelegator
      attr_accessor :navigation, :current

      def initialize(navigable=[], current=nil)
        self.navigation = Array.wrap(navigable)
        self.current = current
        super(navigation)
      end

      def active?(navigable)
        current == navigable
      end
    end
  end
end
