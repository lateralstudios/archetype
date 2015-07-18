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

      def ordered
        sorted = sort do |a, b|
          if a.position && b.position
            a.position <=> b.position
          elsif a.position || b.position
            a.position ? -1 : 1
          else
            a.name <=> b.name
          end
        end
        self.class.new(sorted, current)
      end
    end
  end
end
