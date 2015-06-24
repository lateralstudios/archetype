module Archetype
  module Interface
    class Navigation < SimpleDelegator
      attr_accessor :navigation

      def initialize(navigable=[])
        self.navigation = Array.wrap(navigable)
        super(navigation)
      end
    end
  end
end
